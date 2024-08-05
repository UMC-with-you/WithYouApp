//
//  NoticeView.swift
//  CommonUI
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Domain
import SnapKit
import RxSwift
import RxCocoa
import UIKit

public final class NoticeView: BaseUIView {
    
    private let checkImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = WithYouAsset.checkbox.image
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        label.text = "NOTICE"
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .center
        return label
    }()
    
    public let addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = WithYouAsset.mainColorDark.color
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 1
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
//        button.layer.borderColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        return button
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 1
        return sv
    }()
    
    public let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NoticeTableCell.self, forCellReuseIdentifier: NoticeTableCell.cellId)
        tableView.rowHeight = 52
        tableView.separatorStyle = .none
        tableView.allowsMultipleSelection = true
        return tableView
    }()

    public override func initUI() {
        backgroundColor = .white
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true

        addSubview(checkImage)
        addSubview(mainLabel)
        addSubview(addButton)
        addSubview(tableView)
    }
    
    public override func initLayout() {
        self.snp.makeConstraints{
            $0.height.equalTo(179)
        }
        
        checkImage.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalTo(checkImage.snp.trailing).offset(10)
            make.centerY.equalTo(checkImage.snp.centerY)
        }
                
        addButton.snp.makeConstraints { make in
            make.height.width.equalTo(32)
            make.centerY.equalTo(checkImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-15)
        }
                
        tableView.snp.makeConstraints { make in
            make.top.equalTo(checkImage.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
}
