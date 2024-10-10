//
//  NickNameViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import UIKit
import SnapKit

class NickNameViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "사용할 닉네임을 입력하세요"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "닉네임 입력"
        tf.textAlignment = .center
        return tf
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let checkButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 18)
        button.setTitle("확인하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = WithYouAsset.subColor.color
        button.layer.cornerRadius = 20
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        return button
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        nickNameTextField.delegate = self
        
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(logoImageView)
        view.addSubview(mainLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(underlineView)
        view.addSubview(checkButton)
    }
    
    private func setConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.width.equalTo(120)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(15)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-80)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(40)
            make.trailing.equalToSuperview().offset(-40)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(10)
            make.leading.trailing.equalTo(nickNameTextField)
            make.height.equalTo(1)
        }
        
        checkButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(40)
        }
    }
    
    @objc func checkButtonTapped() {
        if !nickNameTextField.hasText {
            let alert = UIAlertController(title: "에러", message: "닉네임을 올바르게 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default))
            self.present(alert, animated: true)
        } else {
            let profileSetViewController = ProfileSetViewController()
            profileSetViewController.nickName = nickNameTextField.text!
            self.navigationController?.pushViewController(profileSetViewController, animated: true)
        }
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
