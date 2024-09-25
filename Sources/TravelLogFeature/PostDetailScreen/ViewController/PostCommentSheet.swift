//
//  PostCommentSheet.swift
//  WithYou
//
//  Created by bryan on 9/19/24.
//

import Foundation
import SnapKit
import RxGesture
import UIKit

class PostCommentSheet: BaseViewController {
    
    private let viewModel : PostCommentViewModel
    
    private let commentView = PostCommentView()
    
    init(viewModel: PostCommentViewModel) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadComments()
    }
    
    override func setUp() {
        view.addSubview(commentView)
    }
    
    override func setUpViewProperty() {
        view.backgroundColor = .white
    }
    
    override func setLayout() {
        commentView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        registerForKeyboardNotifications()
    }
    
    override func setDelegate() {
        commentView.collectionView.delegate = self
        commentView.collectionView.dataSource = self
        commentView.commentTextField.delegate = self
    }
    
    override func setFunc() {
        commentView.sendButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe(onNext: { (owner ,_ )in
                //추가
                if let text = owner.commentView.commentTextField.text {
                    owner.viewModel.addCommnet(text)
                }
            })
            .disposed(by: disposeBag)
        
        commentView.closeButton
            .rx
            .tap
            .withUnretained(self)
            .subscribe { (owner,_) in
                owner.dismiss(animated: true)
            }
            .disposed(by: disposeBag)
        

        viewModel.isReply
            .withUnretained(self)
            .subscribe { (owner, isReply) in
                owner.changeTextFieldHolder(isReply)
            }
            .disposed(by: disposeBag)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false // Allow other interactions (e.g., buttons)
        view.addGestureRecognizer(tapGesture)
        
    }
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func unregisterForKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func dismissKeyboard() {
        self.view.endEditing(true) // This will dismiss the keyboard
    }
}

extension PostCommentSheet {
    private func reply(_ commentId : Int){
        commentView.commentTextField.becomeFirstResponder()
        viewModel.isReply.onNext(true)
    }
    
    private func changeTextFieldHolder(_ isReply: Bool){
        if isReply {
            commentView.commentTextField.placeholder = "답글을 입력해주세요"
        } else {
            commentView.commentTextField.placeholder = "내용을 입력해주세요"
        }
    }
}


extension PostCommentSheet : UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.post.comments.count // Array of top-level comments
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.post.comments[section]?.replys.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentReplyCell.cellId, for: indexPath) as! CommentReplyCell
        if let reply = viewModel.post.comments[indexPath.section]?.replys[indexPath.row] {
            cell.configure(reply)
            cell
                .replyButton
                .rx
                .tapGesture()
                .when(.recognized)
                .withUnretained(self)
                .subscribe { (owner, _) in
                    if let comment = owner.viewModel.post.comments[indexPath.section] {
                        owner.reply(comment.commentId)
                    } else {
                        print("코멘트 에러")
                    }
                }
                .disposed(by: disposeBag)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CommentCell.cellId, for: indexPath) as! CommentCell
            if let comment = viewModel.post.comments[indexPath.section]{
                header.configure(comment)
            }
            
            //Bind TapGesture
            header
                .replyButton
                .rx
                .tapGesture()
                .when(.recognized)
                .withUnretained(self)
                .subscribe(onNext: {(owner, _) in
                    if let comment = owner.viewModel.post.comments[indexPath.section] {
                        owner.reply(comment.commentId)
                    } else {
                        print("코멘트 에러")
                    }
                })
                .disposed(by: header.disposeBag)
            
            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 30, height: 60)
    }
}


extension PostCommentSheet : UITextFieldDelegate {
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        viewModel.isReply.onNext(false)
        self.view.endEditing(true)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.isReply.onNext(false)
        return self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        // Get the keyboard height
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        let keyboardHeight = keyboardFrame.height
        
        // Move the textField above the keyboard
        self.commentView.bottomBar.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(keyboardHeight + 10) // Adjust according to keyboard height
        }
        self.commentView.layoutIfNeeded()
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        // Move the textField back to its original position
        viewModel.isReply.onNext(false)
        self.commentView.bottomBar.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(20) // Reset back to the original position
        }
        self.commentView.layoutIfNeeded()
    }
    
}
