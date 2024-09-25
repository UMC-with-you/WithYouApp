//
//  PostCommentView.swift
//  WithYou
//
//  Created by bryan on 9/19/24.
//

import Foundation
import UIKit

public class PostCommentView : BaseUIView {
    lazy var topBar = UIView()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 17)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(WithYouAsset.xmark.image, for: .normal)
        button.tintColor = .black
        return button
    }()
    
    lazy var collectionView = {
        // Setup the layout
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

        // Setup the collectionView
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white

        // Register cells and headers
        cv.register(CommentReplyCell.self, forCellWithReuseIdentifier: CommentReplyCell.cellId)
        cv.register(CommentCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CommentCell.cellId)
        return cv
    }()
    
    
    lazy var textFieldBackground = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    // Text field for adding a new comment
    lazy var commentTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.placeholder = "내용을 입력해주세요"
        textField.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        return textField
    }()
    
    // Button to submit a comment
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(systemName: "paperplane.fill")
        button.setImage(image, for: .normal)
        button.tintColor = WithYouAsset.mainColorDark.color
        return button
    }()
    
    lazy var bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white        
        return view
    }()
    
    
    override public func initUI() {
        
        [titleLabel, closeButton].forEach{
            topBar.addSubview($0)
        }
        
        textFieldBackground.addSubview(commentTextField)
        
        [textFieldBackground, sendButton].forEach{
            bottomBar.addSubview($0)
        }
        
        [collectionView, bottomBar, topBar].forEach{
            self.addSubview($0)
        }
    }
    
    override public func initLayout() {
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(topBar.snp.bottom) // below title bar
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(bottomBar.snp.top)
        }
          
        bottomBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(60)
        }
        
        textFieldBackground.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(sendButton.snp.leading).offset(-15)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints { make in
//            make.leading.equalTo(commentTextField.snp.trailing).offset(10)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }

        // Set up layout for title bar
        topBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(64)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalTo(topBar)
        }
        
        closeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-15)
            make.width.height.equalTo(32)
        }
    }
}

