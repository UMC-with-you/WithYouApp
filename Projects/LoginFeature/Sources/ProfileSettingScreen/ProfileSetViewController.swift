//
//  ProfileSetViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import UIKit
import RxSwift
import SnapKit

class ProfileSetViewController: UIViewController {
    
    var bag = DisposeBag()
    
    var nickName: String?
    
    let button = WYAddButton(.big)
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "사용할 프로필 사진을 설정하세요"
        label.font = UIFont(name: "Pretendard-SemiBold", size: 20)
        label.textColor = UIColor(named: "MainColorDark")
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = WithYouAsset.subColor.color.cgColor
        imageView.layer.cornerRadius = 100 // 원하는 라운드 값으로 수정
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
    
    let nickNameSelectButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임으로 프로필 설정하기", for: .normal)
        button.setTitleColor(UIColor(named: "MainColorDark"), for: .normal)
        button.addTarget(self, action: #selector(nickNameSetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "MainColorDark")
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let button = WYButton("완료")
        button.backgroundColor = WithYouAsset.mainColorDark.color
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 30)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
        setViews()
        setConstraints()
    }
    
    private func setViews() {
        view.addSubview(mainLabel)
        view.addSubview(profileImageView)
        view.addSubview(selectImageButton)
        view.addSubview(cancelImageButton)
        view.addSubview(nickNameSelectButton)
        view.addSubview(underlineView)
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-200)
        }
        
        profileImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(200)
        }
        
        selectImageButton.snp.makeConstraints { make in
            make.center.equalTo(profileImageView)
        }
        
        cancelImageButton.snp.makeConstraints { make in
            make.centerX.equalTo(profileImageView.snp.right)
            make.centerY.equalTo(profileImageView.snp.top)
        }
        
        nickNameSelectButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(50)
        }
        
        underlineView.snp.makeConstraints { make in
            make.top.equalTo(nickNameSelectButton.snp.bottom).offset(1)
            make.leading.trailing.equalTo(nickNameSelectButton)
            make.height.equalTo(1)
        }
    }
    
    @objc func nickNameSetButtonTapped() {
        let nameProfileViewController = NameProfileViewController()
        nameProfileViewController.nickName = nickName
        
        nameProfileViewController.newImage.subscribe(onNext: { image in
            self.profileImageView.image = image
            self.selectImageButton.isHidden = true
            self.cancelImageButton.isHidden = false
        })
        .disposed(by: bag)
        
        navigationController?.pushViewController(nameProfileViewController, animated: true)
    }
    
    @objc func doneButtonTapped() {
        guard let image = profileImageView.image else {return}
        guard let name = nickName else {return}
//        DataManager.shared.saveImage(image: image, key: "ProfilePicture")
//        DataManager.shared.saveText(text: name, key: "UserName")
//        DataManager.shared.setIsLogin()
        
        // 메인 화면으로 가기
//        let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
//        guard let delegate = sceneDelegate else { return }
//        delegate.window?.rootViewController = TabBarViewController()
    }
}

// 도경 : Delegate 관련 extension으로 빼고 함수 정렬
extension ProfileSetViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

