//
//  OnBoarding3.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class OnBoarding3: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        label.text = "여행이 끝난 후,"
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "Photo Book에서 우리만의 피드를 꾸미고\n\nRewind Book으로 그 날의 기억을 추억해요."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lastLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "우리만의 공유클라우드로\n미디어를 쉽고 편하게 업로드하고 내려받을 수 있어요!"
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
