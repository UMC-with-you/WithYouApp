//
//  OnBoarding1.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class OnBoarding1: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        label.text = "여행 전,"
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "공유된 여행 Log 페이지에서\n중요한 사항들을 공유하고, 쉽게 확인해요!"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lastLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "공동의 짐은\n공유 체크리스트를 통해 다 함께 챙겨요!"
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


    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .white
        backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
        addSubview(mainLabel)
        addSubview(subLabel)
        addSubview(lastLabel)
    
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setConstraints() {
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        lastLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-120)

        }
    }
}
