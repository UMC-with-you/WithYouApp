//
//  BaseOnBoarding.swift
//  WithYou
//
//  Created by 배수호 on 4/8/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import SnapKit
import UIKit

class BaseOnBoarding: BaseUIView {
    
    let title: String?
    let description1: String
    let description1Bold: NSRange?
    let description2: String
    let description2Bold: NSRange?
    let mockUpImage: UIImage?
    
    init(title: String, description1: String, description1Bold: NSRange? = nil, description2: String, description2Bold: NSRange? = nil, mockUpImage: UIImage? = nil) {
        self.title = title
        self.description1 = description1
        self.description1Bold = description1Bold
        self.description2 = description2
        self.description2Bold = description2Bold
        self.mockUpImage = mockUpImage
        super.init(frame: .zero)
               initUI()
               initLayout()
    }
    
    @MainActor public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Medium", size: 21)
        label.textColor = UIColor(red: 0.584, green: 0.741, blue: 0.824, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel1: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 17)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 17)
        label.textAlignment = .center
        return label
    }()
    
    let mockUpImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "MockUp")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override func initUI() {
        backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        addSubview(mainLabel)
        addSubview(subLabel1)
        addSubview(subLabel2)
        addSubview(mockUpImageView)
        
        mainLabel.text = title
        subLabel1.text = description1
        if let range = description1Bold {
              subLabel1.setBoldFont("Pretendard-SemiBold", range: range)
          }
          subLabel2.text = description2
          if let range = description2Bold {
              subLabel2.setBoldFont("Pretendard-SemiBold", range: range)
          }
        mockUpImageView.image = mockUpImage
    }
    
    override func initLayout() {
        
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(CGFloat(134).adjustedH)
        }
        
        subLabel1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(CGFloat(27).adjustedH)
        }
        
        subLabel2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subLabel1.snp.bottom).offset(CGFloat(6).adjustedH)
        }
        
        mockUpImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
}
