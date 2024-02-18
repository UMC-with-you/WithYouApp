import UIKit
import SnapKit

struct PostComment {
    let name: String
    let comment: String
    let image: UIImage
}

class ModalViewController: UIViewController {
    
    var comments: [PostComment]  = []
    
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
        tableView.dataSource = self // 데이터 소스 설정
        tableView.delegate = self // 델리게이트 설정
        return tableView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    func test() {
        for i in 1...40 {
            comments.append(PostComment(name: "test", comment: "\(i)test1111111323232323232323223232323232323323232323232323232323232322333232311111", image: WithYouAsset.myIcon.image))
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
        
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(commentTextView)
        view.addSubview(tableView)
        view.addSubview(sendButton)
        view.addSubview(placeholder)
        
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
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
        
        let navItem = UINavigationItem(title: "댓글")
        let rightButton = UIBarButtonItem(image: UIImage(named: "xmark")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(tapDisMissButton))
        rightButton.tintColor = .black
        navigationBar.setItems(([navItem]), animated: true)
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        navItem.rightBarButtonItem = rightButton
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
        
        // 키보드가 나타날 때와 사라질 때의 알림(Notification)을 등록
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func refresh() {
            // 리프레시 액션에서 서버 데이터를 다시 로드하고 테이블 뷰를 다시 로드합니다.
            tableView.reloadData()
//        comments.insert(Comment(name: "경주", comment: "refresh", image: WithYouAsset.myIcon.image), at: 0)
//        
            refreshControl.endRefreshing() // 리프레시 종료
        }
    
    @objc func sendButtonTapped() {
        // Check if textView contains text
        guard let commentText = commentTextView.text, !commentText.isEmpty else {
            // Handle case where textView is empty
            return
        }
        
        // Add the new comment to the comments array
        comments.insert(PostComment(name: "경주", comment: commentTextView.text , image: WithYouAsset.myIcon.image), at: 0)
        
        // Update the tableView
        tableView.beginUpdates()
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .top)
        tableView.endUpdates()
        
        // Clear the textView after sending
        commentTextView.text = ""
        placeholder.isHidden = false // Show the placeholder label again
        
        // Dismiss the keyboard
        commentTextView.resignFirstResponder()
    }


    // MARK: - UITextViewDelegate
    
    
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
    
    var keyHeight: CGFloat?
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

extension ModalViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
}

extension ModalViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count // 댓글의 수 반환
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CommentTableViewCell(style: .default, reuseIdentifier: "Cell")
        // 셀에 댓글 내용 표시
        cell.commentLabel.text = comments[indexPath.row].comment
        cell.profileImage.image = comments[indexPath.row].image
        cell.nameLabel.text = comments[indexPath.row].name
        return cell
    }
}

extension ModalViewController: UITableViewDelegate {
    // Additional delegate methods can be implemented here if needed
}
