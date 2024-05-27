//
//  OnBoardingCell.swift
//  LoginFeature
//
//  Created by 김도경 on 5/27/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

class OnBoardingCell: UICollectionViewCell {
    
    static let cellId = "OnBoardingCell"
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 20)
        label.textColor = UIColor(red: 0.584, green: 0.741, blue: 0.824, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let mockUpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ data : CellData){
        mainLabel.text = data.mainText
        subLabel.text = data.subText
        mockUpImageView.image = UIImage(named: data.image)
    }
    
    func initUI() {
        backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(mockUpImageView)
    }
    
    func initLayout() {
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(subLabel.snp.top).offset(-10)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(mockUpImageView.snp.top).offset(-5)
        }
        
        mockUpImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
