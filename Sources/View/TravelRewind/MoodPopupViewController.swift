import UIKit
import SnapKit

class MoodPopupViewController: UIViewController {

    let images: [UIImage?] = [
        UIImage(named: "heart"),
        UIImage(named: "lucky"),
        UIImage(named: "surprised"),
        UIImage(named: "angry"),
        UIImage(named: "touched"),
        UIImage(named: "sunny"),
        UIImage(named: "sad"),
        UIImage(named: "soso")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // 팝업 배경 설정
        view.backgroundColor = UIColor(white: 0, alpha: 0.1)


        // 닫기 버튼 생성
        let closeButton = UIButton()
        closeButton.setTitle("닫기", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        view.addSubview(closeButton)

        closeButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }

    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
}
