//
//  ProfileSetViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/26.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import UIKit
import RxSwift
import SnapKit

/// 회원가입 두번째 화면
class ProfileSetViewController: UIViewController {
    
    weak var coordinator: ProfileSettingCoordinator?
    
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
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = WithYouAsset.subColor.color.cgColor
        imageView.layer.cornerRadius = 100 // 원하는 라운드 값으로 수정
        return imageView
    }()
    
    lazy var selectImageButton: UIButton = {
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
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        setupBackButton()
    }
    
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
        [mainLabel, profileImageView, selectImageButton, cancelImageButton, nickNameSelectButton, underlineView].forEach { view.addSubview($0) }
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(CGFloat(173).adjustedH)
            $0.centerX.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(CGFloat(257).adjustedH)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        selectImageButton.snp.makeConstraints {
            $0.center.equalTo(profileImageView)
        }
        
        cancelImageButton.snp.makeConstraints {
            $0.centerX.equalTo(profileImageView.snp.right)
            $0.centerY.equalTo(profileImageView.snp.top)
        }
        
        nickNameSelectButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(profileImageView.snp.bottom).offset(80)
        }
        
        underlineView.snp.makeConstraints {
            $0.top.equalTo(nickNameSelectButton.snp.bottom).offset(1)
            $0.leading.trailing.equalTo(nickNameSelectButton)
            $0.height.equalTo(1)
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
        
//        navigationController?.pushViewController(nameProfileViewController, animated: true)
        coordinator?.navigateNameVC()
    }
    
    @objc func doneButtonTapped() {
        guard let image = profileImageView.image else {return}
        guard let name = nickName else {return}
        ProfileUserDefaultManager.profileImage = image;
        ProfileUserDefaultManager.userName = name;
        UserDefaultsManager.isLoggined = true;

        coordinator?.finishProfileSetting()
    }
}

// 도경 : Delegate 관련 extension으로 빼고 함수 정렬
extension ProfileSetViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: - UIImagePickerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.editedImage] as? UIImage {
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
        imagePicker.allowsEditing = true // 시스템 편집기 사용
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 이미지 취소 버튼의 액션 메서드
    @objc func cancelImage() {
        profileImageView.image = UIImage()
        cancelImageButton.isHidden = true
        selectImageButton.isHidden = false
    }
}

