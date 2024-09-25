//
//  NoticeTableCell.swift
//  CommonUI
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

public class NoticeTableCell: UITableViewCell {
    public static let cellId  = "NoticeTableCell"
    
    let profileImageView = ProfileView(size: .small)
      
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()

    let noticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 3
        label.textAlignment = .left
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.setImage(WithYouAsset.iconCheckOff.image, for: .normal)
        button.setImage(WithYouAsset.iconCheckOn.image, for: .selected)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    public let checkLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    let profileContainer: UIView = {
        let sv = UIView()
        return sv
    }()
    
    let checkContainerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndetifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIndetifier)
        setupStackView()
        setConstraints()
    }
    
    func setupStackView() {
        self.selectionStyle = .none
        
        // 뷰컨트롤러의 기본뷰 위에 스택뷰 올리기
        self.addSubview(profileContainer)
        self.addSubview(noticeLabel)
        self.addSubview(checkContainerView)
        
        // 스택뷰 위에 뷰들 올리기
        profileContainer.addSubview(profileImageView)
        profileContainer.addSubview(userNameLabel)
        
        checkContainerView.addSubview(checkButton)
        checkContainerView.addSubview(checkLabel)
        
    }
    
//    // 오토레이아웃 정하는 정확한 시점
//    public override func updateConstraints() {
//        setConstraints()
//        super.updateConstraints()
//    }
    public override func prepareForReuse() {
        super.prepareForReuse()
        checkButton.isSelected = false
        checkLabel.text = "0"
    }
    
    public func bind(notice : Notice){
        noticeLabel.text = notice.noticeContent
        userNameLabel.text = notice.userName
        checkLabel.text = String(notice.checkNum)
        profileImageView.bindImage(image: WithYouAsset.mascout.image)
        
        if notice.checkNum != 0 {
            checkButton.isSelected = true
        } else {
            checkButton.isSelected = false
        }
    }
    
    private func setConstraints() {
        
        profileContainer.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(50)
        }
        
        profileImageView.snp.makeConstraints{
            $0.leading.equalToSuperview()
            $0.top.equalToSuperview()
        }
        
        userNameLabel.snp.makeConstraints{
            $0.centerX.equalTo(profileImageView)
            $0.top.equalTo(profileImageView.snp.bottom).offset(2)
        }
        
        noticeLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileContainer.snp.trailing)
            $0.trailing.equalTo(checkContainerView.snp.leading)
        }
        
        checkContainerView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.width.equalTo(50)
            $0.top.bottom.equalToSuperview()
        }
        
        checkButton.snp.makeConstraints{
            $0.height.width.equalTo(35)
            $0.trailing.equalToSuperview().offset(-5)
        }
        
        checkLabel.snp.makeConstraints{
            $0.centerX.equalTo(checkButton)
            $0.top.equalTo(checkButton.snp.bottom).offset(2)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
