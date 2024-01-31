//
//  NoticeTableViewCell.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class NoticeTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 16
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.quaternaryLabel.cgColor
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()

    let noticeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    let checkButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
        button.isEnabled = true
        return button
    }()
    
    let checkLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "2"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    let profileStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 1
        return sv
    }()
    
    let checkStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 1
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier reuseIndetifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIndetifier)
        setupStackView()
    }
    
    func setupStackView() {
        
        // 뷰컨트롤러의 기본뷰 위에 스택뷰 올리기
        self.addSubview(profileStackView)
        self.addSubview(noticeLabel)
        self.addSubview(checkStackView)
        
        // 스택뷰 위에 뷰들 올리기
        profileStackView.addArrangedSubview(profileImageView)
        profileStackView.addArrangedSubview(userNameLabel)
        
        checkStackView.addArrangedSubview(checkButton)
        checkStackView.addArrangedSubview(checkLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 오토레이아웃 정하는 정확한 시점
    override func updateConstraints() {
        setConstraints()
        super.updateConstraints()
    }
    
    private func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        
        noticeLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileStackView.snp.trailing).offset(15)
            make.top.equalTo(profileImageView.snp.top)
        }
        
        checkButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
        }
        
        profileStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(10)
        }
        
        checkStackView.snp.makeConstraints { make in
            make.centerY.equalTo(self.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-15)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
