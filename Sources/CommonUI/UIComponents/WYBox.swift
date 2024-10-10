//
//  WYBox.swift
//  CommonUI
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public class WYBox : BaseUIView {
    public let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    public let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    public let subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.distribution  = .fill
        sv.alignment = .fill
        sv.spacing = 15
        return sv
    }()
    
    override public func initUI() {
        backgroundColor = .white
        addSubview(mainImage)
        addSubview(mainLabel)
        addSubview(subLabel)
    }
    
    override public func initLayout() {
        mainImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalTo(subLabel.snp.top).offset(-5)
        }
        
        subLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
