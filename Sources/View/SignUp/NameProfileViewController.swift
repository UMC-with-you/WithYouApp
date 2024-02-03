//
//  NameProfileViewController.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/30.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class NameProfileViewController: UIViewController {

    var nickName: String?
    var selectedBackgroundColor: UIColor?

    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "배경 색상을 선택하세요"
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
        imageView.layer.cornerRadius = 100
        return imageView
    }()

    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Pretendard-SemiBold", size: 48)
        return label
    }()

    let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(doneButtonTapped))

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
        
        navigationItem.rightBarButtonItem = doneButton
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

        textLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    @objc func doneButtonTapped() {
        // Handle done button action
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