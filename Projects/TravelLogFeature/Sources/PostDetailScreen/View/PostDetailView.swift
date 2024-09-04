//
//  PostDetailView.swift
//  TravelLogFeature
//
//  Created by bryan on 8/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import Foundation
import UIKit

class PostDetailView : BaseUIView {
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "오징어들의 오사카여행"
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        return label
    }()
    
    lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.text = "2023.11.16 - 2023.11.20"
        label.font = WithYouFontFamily.Pretendard.light.font(size: 12)
        label.textColor = WithYouAsset.gray2.color
        
        return label
    }()
    
    var profileLineView = UIView()
    
    var profilePic = ProfileView(size: .small)
    var posterName = {
        let name = UILabel()
        name.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        name.textColor = .black
        return name
    }()
    var optionButton = {
        let icon = UIButton()
        icon.setTitle("---", for: .normal)
        icon.tintColor = .black
        return icon
    }()
    
    lazy var postCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = WithYouAsset.backgroundColor.color
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.hidesForSinglePage = true
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        pageControl.pageIndicatorTintColor = WithYouAsset.subColor.color
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.isEnabled = false
        return pageControl
    }()
    
    
    lazy var likeConfig: UIImage.Configuration = {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .regular)
        return config
    }()
    
    lazy var messageConfig: UIImage.Configuration = {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .regular)
        return config
    }()
    
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "heart",withConfiguration: likeConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let filledImage = UIImage(systemName: "heart.fill",withConfiguration: likeConfig)?.withTintColor(.red, renderingMode: .alwaysOriginal)
        button.setImage(filledImage, for: .selected)
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var messageButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "message",withConfiguration: messageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        return button
    }()
    
    lazy var bookMarkButton: UIButton = {
        let button = UIButton()
        let fillImage = UIImage(systemName: "bookmark.fill",withConfiguration: messageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let image = UIImage(systemName: "bookmark",withConfiguration: messageConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.setImage(fillImage, for: .selected)
        return button
    }()
    
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var likeCount: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 15)
        label.textColor = .black
        return label
    }()
    
    lazy var contextLabel: UILabel = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 15)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    override func initUI() {
        [titleLabel, periodLabel, profileLineView, postCollectionView, pageControl, likeButton, messageButton, bookMarkButton, likeLabel, likeCount, contextLabel].forEach{
            self.addSubview($0)
        }
        
        [profilePic, posterName, optionButton].forEach{
            profileLineView.addSubview($0)
        }
        
    }
    
    override func initLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        
        // 사용자 이름 및 사진 설정
        profileLineView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.top.equalTo(periodLabel.snp.bottom).offset(15)
            $0.height.equalTo(48)
        }
        profilePic.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
        }
        posterName.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(profilePic.snp.trailing).offset(15)
        }
        optionButton.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        postCollectionView.snp.makeConstraints {
            $0.width.height.equalTo(self.snp.width)
            $0.top.equalTo(profileLineView.snp.bottom)
        }
        
        pageControl.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(postCollectionView.snp.bottom).offset(10)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(postCollectionView.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(15)
        }
        
        messageButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.leading.equalTo(likeButton.snp.trailing).offset(10)
            $0.top.equalTo(likeButton.snp.top)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(likeButton.snp.top)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        likeLabel.snp.makeConstraints {
            $0.top.equalTo(likeButton.snp.bottom).offset(15)
            $0.leading.equalTo(likeButton)
        }
        
    }
}

