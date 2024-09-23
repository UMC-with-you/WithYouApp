//
//  TodayView.swift
//  WithYou
//
//  Created by bryan on 9/23/24.
//

import UIKit

final class TodayView: BaseUIView {
    
    let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let subLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 12)
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
    
    override func initUI() {
        [mainImage,mainLabel, subLabel, stackView].forEach {
            self.addSubview($0)
        }
    }
    
    override func initLayout() {
        mainImage.snp.makeConstraints { make in
            make.width.height.equalTo(32)
            make.top.equalToSuperview().offset(10)
            make.leading.equalToSuperview().offset(10)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(mainImage.snp.bottom).offset(10)
        }
        
        subLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalTo(mainLabel.snp.bottom).offset(10)
        }
    }
}
