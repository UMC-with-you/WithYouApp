import Domain
import UIKit
import RxCocoa
import RxSwift
import SnapKit

struct PostComment {
    let name: String
    let comment: String
    let image: UIImage
}

class CommentModalViewController: UIViewController {
    
    var keyHeight: CGFloat?
    
    private var refreshControl = UIRefreshControl()
    
    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.backgroundColor = .white
        navigationBar.barTintColor = .white
        // 구분선 없애기
        navigationBar.shadowImage = UIImage()
        return navigationBar
    }()
    
    lazy var commentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = WithYouAsset.backgroundColor.color
        textView.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        textView.layer.cornerRadius = 8.0
        textView.isScrollEnabled = false // 스크롤 비활성화
        textView.sizeToFit() // 높이 자동 조절
        textView.delegate = self
        return textView
    }()
    
    lazy var placeholder: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.subColor.color
        label.text = "댓글을 입력하세요"
        return label
    }()
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self // 델리게이트 설정
        return tableView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    var post : Post?
    var log : Log?
    var commentRelay = BehaviorRelay<[Comment]>(value: [])
    
    var members = [Traveler]()
    
    var bag = DisposeBag()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setConst()
        setNavBar()
        setData()
        getDatas()
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
        
        // 키보드가 나타날 때와 사라질 때의 알림(Notification)을 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setData(){
//        LogService.shared.getAllMembers(logId: self.log!.id) { travelers in
//            self.members = travelers
//        }
        
        commentRelay.bind(to: tableView.rx.items(cellIdentifier: CommentTableViewCell.cellId, cellType: CommentTableViewCell.self)){ index, item , cell in
            cell.commentLabel.text = item.content
            print(self.members)
            for member in self.members {
                if item.memberId == member.id {
                    cell.nameLabel.text = member.name
                    cell.profileImage.kf.setImage(with: URL(string: member.profilePicture!))
                }
            }
        }
        .disposed(by: bag)
    }
    private func getDatas(){
//        PostService.shared.getOnePost(postId: self.post!.postId, travelId: self.log!.id) { response in
//            self.commentRelay.accept(response.commentDTOs.map{$0!})
//        }
    }
    
    @objc func refresh() {
            // 리프레시 액션에서 서버 데이터를 다시 로드하고 테이블 뷰를 다시 로드합니다.
            refreshControl.endRefreshing() // 리프레시 종료
        }
    
    @objc func sendButtonTapped() {
        // Check if textView contains text
        guard let commentText = commentTextView.text, !commentText.isEmpty else {
            // Handle case where textView is empty
            return
        }
        
        // Add the new comment to the comments array
//        CommentService.shared.addComment(postId: self.post!.postId, content: commentText){ _ in
//            self.getDatas()
//        }
        
        // Clear the textView after sending
        commentTextView.text = ""
        placeholder.isHidden = false // Show the placeholder label again
        
        // Dismiss the keyboard
        commentTextView.resignFirstResponder()

    }
    
    private func setUp(){
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.cellId)
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(commentTextView)
        view.addSubview(tableView)
        view.addSubview(sendButton)
        view.addSubview(placeholder)
    }
    private func setConst(){
        placeholder.snp.makeConstraints { make in
            make.centerY.equalTo(commentTextView.snp.centerY)
            make.leading.equalTo(commentTextView.snp.leading).offset(10)
        }
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(commentTextView.snp.bottom).offset(-5)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(commentTextView.snp.top)
        }
        commentTextView.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.8)
            // 텍스트뷰가 내용에 따라 자동으로 늘어나도록 높이 제약을 추가하지 않음
            make.leading.equalTo(20)
        }
    }
    private func setNavBar(){
        let navItem = UINavigationItem(title: "댓글")
        let rightButton = UIBarButtonItem(image: UIImage(named: "xmark")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tapDisMissButton))
        rightButton.tintColor = .black
        navigationBar.setItems(([navItem]), animated: true)
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        navItem.rightBarButtonItem = rightButton
    }
}
// MARK: - UITextViewDelegate
extension CommentModalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
    
    @objc func tapDisMissButton(){
        dismiss(animated: true)
    }
    
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // 텍스트 필드의 편집이 종료될 때 호출되는 메서드
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("End Editing")
    }
    
    // return button 눌렀을 떄
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        self.view.endEditing(true)
        return true
    }
   
    @objc func keyboardWillShow(_ sender: Notification) {
        guard keyHeight == nil else {
            return
        }
        let userInfo = sender.userInfo
        let keyboardFrame = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
        let keyboardRectangle = keyboardFrame?.cgRectValue
        let keyboardHeight = keyboardRectangle?.height ?? 0
        keyHeight = keyboardHeight

        self.view.frame.size.height -= keyboardHeight
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        guard let height = keyHeight else {
            return
        }
        
        self.view.frame.size.height += height
        keyHeight = nil
    }

}

extension CommentModalViewController: UITableViewDelegate {
    // Additional delegate methods can be implemented here if needed
}
