//
//  ProfileEditViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/02/06.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class ProfileEditViewController: UIViewController {

    var nickName: String = ""
    
    let button = WYAddButton(.big)
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = WithYouAsset.subColor.color.cgColor
        imageView.layer.cornerRadius = 75 // 원하는 라운드 값으로 수정
        return imageView
    }()
    
    let selectImageButton: UIButton = {
        let button = UIButton()
        
        if let originalImage = UIImage(systemName: "plus.circle.fill") {
            // 원하는 색상으로 이미지 채색
            let tintedColor = UIColor(named: "SubColor") ?? .blue
            let tintedImage = originalImage.withTintColor(tintedColor, renderingMode: .alwaysOriginal)
            
            // 크기 조절
            let newSize = CGSize(width: 50, height: 50)
            let resizedImage = UIGraphicsImageRenderer(size: newSize).image { _ in
                tintedImage.draw(in: CGRect(origin: .zero, size: newSize))
            }
            
            button.setImage(resizedImage, for: .normal)
            button.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        }
        button.backgroundColor = .clear
        
        return button
    }()
    
    let cancelImageButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(cancelImage), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 15)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let nickNameTextField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor(named: "MainColorDark")
        tf.font = UIFont(name: "Pretendard-Regular", size: 16)
        return tf
    }()
    
    let nameLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let nickNameSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임으로 프로필 설정하기", for: .normal)
        button.setTitleColor(UIColor(named: "MainColorDark"), for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        button.addTarget(self, action: #selector(nickNameSetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let nickNameLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MainColorDark")
        return view
    }()
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃하기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = UIFont(name: "Pretendard-Medium", size: 15)
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let logoutLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = "프로필 수정"
        nickNameTextField.delegate = self
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(profileImageView)
        view.addSubview(selectImageButton)
        view.addSubview(cancelImageButton)
        view.addSubview(mainLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(nameLineView)
        view.addSubview(nickNameSelectButton)
        view.addSubview(nickNameLineView)
        view.addSubview(logoutButton)
        view.addSubview(logoutLineView)
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(25)
        }
        
        nickNameTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
        }
        
        nameLineView.snp.makeConstraints { make in
            make.top.equalTo(nickNameTextField.snp.bottom).offset(5)
            make.leading.trailing.equalTo(nickNameTextField)
            make.height.equalTo(1)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-200)
            make.width.height.equalTo(150)
        }
        
        selectImageButton.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(profileImageView)
        }
        
        cancelImageButton.snp.makeConstraints { make in
            make.centerX.equalTo(profileImageView.snp.right)
            make.centerY.equalTo(profileImageView.snp.top)
        }
        
        nickNameSelectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nickNameTextField.snp.bottom).offset(35)
        }
        
        nickNameLineView.snp.makeConstraints { make in
            make.top.equalTo(nickNameSelectButton.snp.bottom).offset(1)
            make.leading.trailing.equalTo(nickNameSelectButton)
            make.height.equalTo(1)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nickNameLineView.snp.bottom).offset(10)
        }
        
        logoutLineView.snp.makeConstraints { make in
            make.top.equalTo(logoutButton.snp.bottom).offset(1)
            make.leading.trailing.equalTo(logoutButton)
            make.height.equalTo(1)
        }
    }
    
    @objc func nickNameSetButtonTapped() {
        let nameProfileViewController = NameProfileViewController()
        nameProfileViewController.nickName = nickNameTextField.text
        _ = nameProfileViewController.newImage.subscribe{ image in
            self.profileImageView.image = image
        }
        navigationController?.pushViewController(nameProfileViewController, animated: true)
    }
    
    @objc func logoutButtonTapped() {
        DataManager.shared.logout()
        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        guard let delegate = sceneDelegate else { return }
        delegate.window?.rootViewController = LoginViewController()
    }
    
    @objc func doneButtonTapped() {
        guard let image = profileImageView.image else {return}
        guard let name = nickNameTextField.text else {return}
        DataManager.shared.saveImage(image: image, key: "ProfilePicture")
        DataManager.shared.saveText(text: name, key: "UserName")
        
        MemberService.shared.changeImage(profilePicture: image){}
        MemberService.shared.changeName(name: name){}
        self.navigationController?.popViewController(animated: true)
    }

}

// 도경 : Delegate 관련 extension으로 빼고 함수 정렬
extension ProfileEditViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            profileImageView.image = selectedImage
            selectImageButton.isHidden = true
            cancelImageButton.isHidden = false
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 이미지 선택 버튼의 액션 메서드
    @objc func selectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 이미지 취소 버튼의 액션 메서드
    @objc func cancelImage() {
        profileImageView.image = UIImage()
        cancelImageButton.isHidden = true
        selectImageButton.isHidden = false
    }
}


extension ProfileEditViewController : UITextFieldDelegate {
    //화면 터치시 키보드 내림
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}
