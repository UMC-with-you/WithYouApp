//
//  LogView.swift
//  WithYou
//
//  Created by 김도경 on 1/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit


class LogView: UIView {
    
    var posting : Posting?
    
    var title = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.bold.font(size: 22)
        label.textColor = .white
        return label
    }()
    
    var date = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 15)
        label.textColor = WithYouAsset.backgroundColor.color.withAlphaComponent(0.7)
        return label
    }()
    
    var dDay = {
        let button = WYButton("")
        button.layer.cornerRadius = 13
        button.titleLabel?.font = WithYouFontFamily.Pretendard.bold.font(size: 15)
        return button
    }()
    
    var backImage = {
        let img = UIImageView(image: UIImage(named: "LogModel1"))
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        return img
    }()

    
    init(frame: CGRect, posting : Posting){
        super.init(frame: frame)
        self.posting = posting
        bind()
        setUp()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(){
    
        title.text = posting?.text
        date.text = posting?.getTravelPeriod()
        dDay.setTitle(dateController.days(from: dateController.strToDate("2024.02.12")), for: .normal)
        dDay.titleLabel?.font = WithYouFontFamily.Pretendard.bold.font(size: 15)
        
        /*
        APIManager.shared.getImage(posting.media) { data in
            self.backImage = UIImageView(image: data as? UIImage)
        }
         */
        
        // Testing Code
        self.backImage.image = UIImage(named: "LogModel\(Int.random(in: 0...2))")
    }
    
    private func setUp(){
        [backImage,title,date,dDay].forEach{
            addSubview($0)
        }
    }
    
    private func setConst(){
        backImage.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
        
        dDay.snp.makeConstraints{
            $0.top.equalToSuperview().offset(25)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalToSuperview().dividedBy(4.5)
            $0.height.equalToSuperview().dividedBy(14)
        }
        
        title.snp.makeConstraints{
            $0.leading.equalTo(dDay)
            $0.bottom.equalTo(date).offset(-20)
        }
        
        date.snp.makeConstraints{
            $0.leading.equalTo(dDay)
            $0.bottom.equalToSuperview().offset(-20)
            
        }
    }
}
