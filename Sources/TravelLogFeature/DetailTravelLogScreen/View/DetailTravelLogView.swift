//
//  DetailTravelLogView.swift
//  TravelLogFeature
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//



import Foundation
import UIKit

public class DetailTravelLogView : BaseUIView {
    let topTitleLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.bold.font(size: 32)
        label.text = "Travelog"
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .left
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-Regular", size: 20)
        label.text = "오징어들의 오사카 여행"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    let underLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.92, green: 0.95, blue: 0.96, alpha: 1)
        return view
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = .gray
        return label
    }()
    
    let memberTitleLabel = {
        let label = UILabel()
        label.font = UIFont(name: "Pretendard-SemiBold", size: 18)
        label.text = "함께한 친구"
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var memberCollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20// cell사이의 간격 설정
        flowLayout.minimumInteritemSpacing = 1
        flowLayout.estimatedItemSize = CGSize(width: 70, height: 88)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 9, right: 0)
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .white
        view.register(MemberCell.self, forCellWithReuseIdentifier: MemberCell.id)
        return view
    }()
    
    let subLabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        label.textColor = .black
        label.text = "우리의 기록"
        return label
    }()
    
    let postBookView : UIView = {
        let view = WYBox()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 196/255, green: 215/255, blue: 250/255, alpha: 1)
        let systemImage = UIImage(named: "Postbook")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "Post Book"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "여행을 함께한 우리만의 SNS"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let rewindBookView: UIView = {
        let view = WYBox()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 154/255, green: 148/255, blue: 188/255, alpha: 1)
        let systemImage = UIImage(named: "Rewind")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "Rewind Book"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "오늘의 Rewind 모아보기"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let cloudVIew: UIView = {
        let view = WYBox()
        view.layer.cornerRadius = 10
        view.backgroundColor = UIColor(red: 242/255, green: 177/255, blue: 219/255, alpha: 1)
        let systemImage = UIImage(named: "Cloud")?.withRenderingMode(.alwaysTemplate)
        view.mainImage.image = systemImage?.withTintColor(.white)
        view.mainLabel.text = "Cloud"
        view.mainLabel.textAlignment = .left
        view.subLabel.text = "우리들의 사진공유"
        view.subLabel.textAlignment = .left
        view.mainImage.tintColor = .white
        return view
    }()
    
    let sideMenu = UIImageView(image: WithYouAsset.sideMenu.image)
    
    override public func initUI() {
        [topTitleLabel,mainLabel,dateLabel,memberTitleLabel,memberCollectionView,subLabel,postBookView,rewindBookView,cloudVIew].forEach{
            self.addSubview($0)
        }
    }
    
    override public func initLayout() {
        topTitleLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        mainLabel.snp.makeConstraints{
            $0.top.equalTo(topTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(topTitleLabel)
        }
        
        self.addUnderline(to: mainLabel, thickness: 7, color: WithYouAsset.underlineColor.color)
        
        dateLabel.snp.makeConstraints{
            $0.top.equalTo(mainLabel.snp.bottom).offset(10)
            $0.leading.equalTo(topTitleLabel)
        }
        
        memberTitleLabel.snp.makeConstraints{
            $0.top.equalTo(dateLabel.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(topTitleLabel)
        }
        
        memberCollectionView.snp.makeConstraints{
            $0.width.equalTo(topTitleLabel.snp.width)
            $0.height.equalToSuperview().multipliedBy(0.13)
            $0.top.equalTo(memberTitleLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints{
            $0.leading.equalTo(topTitleLabel)
            $0.top.equalTo(memberCollectionView.snp.bottom).offset(25)
        }
        
        postBookView.snp.makeConstraints{
            $0.top.equalTo(subLabel.snp.bottom).offset(10)
            $0.leading.equalTo(topTitleLabel)
            $0.width.equalTo(topTitleLabel).dividedBy(2.1)
            $0.height.equalTo(120)
        }
        
        rewindBookView.snp.makeConstraints{
            $0.top.equalTo(postBookView)
            $0.trailing.equalToSuperview().offset(-15)
            $0.width.equalTo(topTitleLabel).dividedBy(2.1)
            $0.height.equalTo(120)
        }
        
        cloudVIew.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(rewindBookView.snp.bottom).offset(15)
            $0.width.equalTo(topTitleLabel)
            $0.height.equalTo(120)
        }
    }
}

