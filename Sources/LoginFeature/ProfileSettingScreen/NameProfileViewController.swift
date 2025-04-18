//
//  NameProfileViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/30.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import UIKit
import RxSwift
import SnapKit

/// 회원가입 세번째 화면
class NameProfileViewController: UIViewController {
    
    var nickName: String?
    var newImage : PublishSubject<UIImage> = PublishSubject()
    var selectedBackgroundColor: UIColor?
    
    weak var coordinator: ProfileSettingCoordinator?
    
    private let disposeBag = DisposeBag()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "배경 색상을 선택하세요"
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
        imageView.layer.cornerRadius = 100
        return imageView
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 48)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setViews()
        setConstraints()
        
        if let nickName = nickName {
            textLabel.text = nickName
        }
    }
    
    private func setViews() {
        view.addSubview(mainLabel)
        view.addSubview(profileImageView)
        profileImageView.addSubview(textLabel)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        let button = WYButton("완료")
        button.backgroundColor = WithYouAsset.mainColorDark.color
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 30)
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    private func setConstraints() {
        mainLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-200)
        }
        
        profileImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(200)
        }
        
        textLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func doneButtonTapped() {
        // 닉네임 이미지로 만들어서 보내기
        //newImage.onNext(self.profileImageView.asImage())
        newImage.onCompleted()
        //        self.navigationController?.popViewController(animated: true)
        
        coordinator?.finishProfileSetting()
    }
    
    @objc func profileImageTapped() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        present(colorPickerVC, animated: true, completion: nil)
    }
}

extension NameProfileViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        selectedBackgroundColor = viewController.selectedColor
        profileImageView.backgroundColor = selectedBackgroundColor
    }
}
