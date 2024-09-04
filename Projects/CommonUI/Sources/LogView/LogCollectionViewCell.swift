//
//  LogGridViewCell.swift
//  WithYou
//
//  Created by 김도경 on 1/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import Domain
import Kingfisher
import SnapKit
import RxSwift
import RxGesture
import UIKit

public class LogCollectionViewCell: UICollectionViewCell {
    public static let cellId = "LogCollectionViewCell"
    
    var disposeBag = DisposeBag()
    
    var title = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    var date = {
        let label = UILabel()
        label.textColor = WithYouAsset.backgroundColor.color.withAlphaComponent(0.7)
        return label
    }()
    
    var backImage = {
        let img = UIImageView(image: UIImage(named: "LogModel0"))
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        return img
    }()
    
    var imageBackGround = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 15
        return view
    }()
    
    //For Big Size Only
    var dDay = {
        let button = WYButton("")
        button.layer.cornerRadius = 13
        return button
    }()
    
    override init(frame : CGRect){
        super.init(frame: frame)
        setUp()
    }
    
    public func bind(log: Log, isBigCell : Bool){
        self.title.text = log.title
        self.date.text = log.getTravelPeriod()
        dDay.setTitle(dateController.days(from:log.startDate), for: .normal)
        
        //self.backImage.kf.setImage(with: URL(string: log.imageUrl))
        self.backImage.image = WithYouAsset.logModel1.image
    
        setConst(isBigCell)
        setSize(isBigCell)
    }
    
    private func setSize(_ isBigCell : Bool){
        title.font = WithYouFontFamily.Pretendard.bold.font(size: isBigCell ? 22 : 16)
        date.font = WithYouFontFamily.Pretendard.medium.font(size: isBigCell ? 15 : 12)
        //Only for big cell
        dDay.titleLabel?.font = WithYouFontFamily.Pretendard.bold.font(size: 15)
    }
    
    private func setUp(){
        self.clipsToBounds = true
        
        [backImage,imageBackGround,title,date].forEach{
            addSubview($0)
        }
    }
    
    private func setConst(_ isBigCell : Bool){
        backImage.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
        
        imageBackGround.snp.makeConstraints{
            $0.width.height.equalToSuperview()
        }
        
        title.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(isBigCell ? 20: 10)
            $0.bottom.equalTo(date).offset(isBigCell ? -20 : -15)
        }
        
        date.snp.makeConstraints{
            $0.leading.equalTo(title)
            $0.bottom.equalToSuperview().offset(isBigCell ? -20 : -10)
        }
        
        if isBigCell {
            addSubview(dDay)
            dDay.snp.makeConstraints{
                $0.top.equalToSuperview().offset(25)
                $0.leading.equalToSuperview().offset(20)
                $0.width.equalToSuperview().dividedBy(4.5)
                $0.height.equalToSuperview().dividedBy(14)
            }
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
