//
//  HomeLogView.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import UIKit
import SnapKit

class HomeLogView : BaseUIView{
    
    var logCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width * 0.75, height: UIScreen.main.bounds.height * 0.45)
        layout.minimumLineSpacing = 17
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.register(LogCollectionViewCell.self, forCellWithReuseIdentifier: LogCollectionViewCell.cellId)
        cv.contentInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 30)
        cv.showsHorizontalScrollIndicator = false
        cv.decelerationRate = .fast
        return cv
    }()
    
    let eclipse = {
        let view = UIView()
        view.frame = CGRect(x: 0,y: 0,width: 5,height: 5)
        view.backgroundColor = WithYouAsset.mainColorDark.color
        view.layer.cornerRadius = view.frame.width / 2
        return view
    }()
    
    let upcoming = {
        let label = UILabel()
        label.text = "UPCOMING"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
        label.textColor = .black
        return label
    }()
    
    let ing = {
        let label = UILabel()
        label.text = "ING"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 18)
        label.textColor = .black
        return label
    }()
    
    let sortIcon = {
        let img = UIImageView(image: WithYouAsset.sortIcon.image)
        return img
    }()
    
    var eclipseConstraint : Constraint?

    
    override func initUI() {
        [logCollectionView,eclipse,upcoming,ing,sortIcon].forEach{
            self.addSubview($0)
        }
    }
    
    override func initLayout() {
        logCollectionView.snp.makeConstraints{
            $0.top.equalTo(ing.snp.bottom).offset(30)
            $0.width.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        ing.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview().offset(-60)
        }
        
        upcoming.snp.makeConstraints{
            $0.top.equalTo(ing.snp.top)
            $0.leading.equalTo(ing.snp.trailing).offset(50)
        }
        
        eclipse.snp.makeConstraints{
            $0.top.equalTo(ing.snp.bottom).offset(10)
            self.eclipseConstraint = $0.centerX.equalTo(ing.snp.centerX).constraint
            $0.width.height.equalTo(5)
        }
        
        sortIcon.snp.makeConstraints{
            $0.top.equalTo(ing.snp.top)
            $0.height.equalTo(23)
            $0.width.equalTo(26)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    public func moveEclipse(state: Bool){
        self.eclipseConstraint?.deactivate()
        self.eclipse.snp.makeConstraints{
            self.eclipseConstraint = $0.centerX.equalTo(state ? ing.snp.centerX : upcoming.snp.centerX).constraint
        }
    }
}
