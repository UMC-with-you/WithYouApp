//
//  OnBoarding2.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

final class OnBoarding2: UIView {
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        label.text = "오늘의 여행은 어떠셨나요?"
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "하루가 끝나고,\n'오늘의 여행 Rewind'를 통해\nwith 'you'가 묻는 질문에 답하며\n오늘의 여행을 기록해보세요."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let lastLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.301, green: 0.301, blue: 0.301, alpha: 1)
        label.font = UIFont(name: "Pretendard-Regular", size: 16)
        label.textAlignment = .center
        label.text = "함께 여행한 You들에게\n하루에 하나, 오늘의 한마디를 전해주세요."
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
