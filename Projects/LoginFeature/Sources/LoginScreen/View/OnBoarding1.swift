//
//  OnBoardingView.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import SnapKit
import UIKit

final class OnBoarding1: BaseUIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 20)
        label.text = "우리 여행의 한 페이지"
        label.textColor = UIColor(red: 0.584, green: 0.741, blue: 0.824, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "Travel Log를 만들어\n함께 여행하는 사람들을 초대해보세요!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let mockUpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MockUp")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func initUI() {
        backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(mockUpImageView)
    }
    
    override func initLayout() {
        
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
