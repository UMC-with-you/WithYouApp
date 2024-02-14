import UIKit
import SnapKit

class ModalViewController: UIViewController, UITextViewDelegate {
    
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
        // textView.placeholder = "내용을 입력하세요"
        textView.backgroundColor = WithYouAsset.backgroundColor.color
        textView.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        textView.layer.cornerRadius = 8.0
        textView.isScrollEnabled = false // 스크롤 비활성화
        textView.sizeToFit() // 높이 자동 조절
        textView.delegate = self // UITextViewDelegate 할당
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
        return tableView
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane")?.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        view.addSubview(commentTextView)
        view.addSubview(tableView)
        view.addSubview(sendButton)
        view.addSubview(placeholder)
        
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
        
        navigationBar.setItems([navItem], animated: true)
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = !textView.text.isEmpty
    }
    
    @objc func tapDisMissButton(){
        dismiss(animated: true)
    }
}
