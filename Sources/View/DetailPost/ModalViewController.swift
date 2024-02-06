
import UIKit
import SnapKit
class ModalViewController: UIViewController {
    
    var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        navigationBar.backgroundColor = .white
        
        return navigationBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(navigationBar)
        
        let navItem = UINavigationItem(title: "댓글")
        let leftButton = UIBarButtonItem(title: "닫기", style: .plain, target: self, action: #selector(tapDisMissButton))
        navigationBar.setItems(([navItem]), animated: true)
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        navItem.leftBarButtonItem = leftButton
        
        navigationBar.setItems([navItem], animated: true)
        
        if let sheetPresentationController = sheetPresentationController {
            sheetPresentationController.detents = [.medium(), .large()]
            sheetPresentationController.prefersGrabberVisible = true
        }
    }
    
    @objc func tapDisMissButton(){
        dismiss(animated: true)
    }
}



