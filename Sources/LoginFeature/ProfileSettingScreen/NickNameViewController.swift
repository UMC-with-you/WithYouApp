//
//  NickNameViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import UIKit
import SnapKit

/// 회원가입 첫번째 화면
class NickNameViewController: UIViewController {
    
    weak var coordinator: ProfileSettingCoordinator?
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.text = "사용할 닉네임을 입력하세요"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    lazy var nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임 입력"
        tf.textAlignment = .center
        return tf
    }()
    
    lazy var underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = WithYouAsset.subColor.color
        return view
    }()
    
    lazy var checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        button.setTitle("다음", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = WithYouAsset.subColor.color
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        nickNameTextField.delegate = self
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        [logoImageView, mainLabel, nickNameTextField, underlineView, checkButton].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(40)
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(15)
        }
        
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-80)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(mainLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(CGFloat(68).adjusted)
            $0.trailing.equalToSuperview().offset(CGFloat(-68).adjusted)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            $0.leading.trailing.equalTo(nickNameTextField)
            $0.height.equalTo(1)
        }
        
        checkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-40)
            $0.width.equalToSuperview().multipliedBy(0.9)
            $0.height.equalTo(CGFloat(52).adjustedH)
        }
    }
    
    @objc func checkButtonTapped() {
//        if !nickNameTextField.hasText {
//            let alert = UIAlertController(title: "에러", message: "닉네임을 올바르게 입력해주세요", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "확인", style: .default))
//            self.present(alert, animated: true)
//        } else {
//            let profileSetViewController = ProfileSetViewController()
//            profileSetViewController.nickName = nickNameTextField.text!
////            self.navigationController?.pushViewController(profileSetViewController, animated: true)
//            coordinator?.navigateProfileSetVC()
//        }
        guard let nickName = nickNameTextField.text, !nickName.isEmpty else {
            let alert = UIAlertController(title: "잠깐만요!", message: "닉네임을 올바르게 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
            return
        }
        
        coordinator?.navigateProfileSetVC(nickName: nickNameTextField.text!)
    }
}

extension NickNameViewController : UITextFieldDelegate{
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count == 0 {
            checkButton.backgroundColor = WithYouAsset.mainColorDark.color
        } else {
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if !textField.hasText {
            checkButton.backgroundColor = WithYouAsset.subColor.color
        }
    }
}
