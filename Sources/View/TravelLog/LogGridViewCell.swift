//
//  LogGridViewCell.swift
//  WithYou
//
//  Created by 김도경 on 1/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import RxSwift
import RxGesture
import UIKit

class LogGridViewCell: UICollectionViewCell {
    
    var disposeBag = DisposeBag()
    
    var title = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.bold.font(size: 16)
        label.textColor = .white
        return label
    }()
    
    var date = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 12)
        label.textColor = WithYouAsset.backgroundColor.color.withAlphaComponent(0.7)
        return label
    }()
    
    var backImage = {
        let img = UIImageView(image: UIImage(named: "LogModel1"))
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        setUp()
        setConst()
    }
    
    public func bind(log: Log){
        self.title.text = log.text
        self.date.text = log.startDate + "~" + log.endDate.dropFirst(4)
    }
    
    private func setUp(){
        [backImage,title,date].forEach{
            addSubview($0)
        }
    }
    
    private func setConst(){
        backImage.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
        
        title.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.bottom.equalTo(date).offset(-20)
        }
        
        date.snp.makeConstraints{
            $0.leading.equalTo(title)
            $0.bottom.equalToSuperview().offset(-20)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
