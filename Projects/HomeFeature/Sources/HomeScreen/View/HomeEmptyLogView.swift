//
//  HomeEmptyLogView.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import UIKit

class HomeEmptyLogView: BaseUIView {
    let info = {
       let label = UILabel()
        label.text = "Travel Log를 만들어 \n with 'You'를 시작해보세요!"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.numberOfLines = 2
        label.textColor = UIColor(named: "MainColorDark")
        label.setLineSpacing(spacing: 10)
        label.textAlignment = .center
        return label
    }()
    
    let mascout = {
        let img = UIImageView(image: WithYouAsset.mascout.image)
        return img
    }()

    override func initUI() {
        [info,mascout].forEach{
            self.addSubview($0)
        }
    }
    
    override func initLayout() {
        mascout.snp.makeConstraints{
            $0.height.equalTo(58)
            $0.width.equalTo(115)
            $0.bottom.equalTo(info.snp.top).offset(-35)
            $0.centerX.equalToSuperview()
        }
        
        info.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-30)
        }
    }
}
