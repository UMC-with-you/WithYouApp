//
//  PostDetailView.swift
//  TravelLogFeature
//
//  Created by bryan on 8/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//



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
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 12)
        label.textColor = WithYouAsset.subColor.color
        
        return label
    }()
    
    var profileLineView = {
        let view = UIView()
        view.backgroundColor = WithYouAsset.subColor.color
        return view
    }()
    
    var profilePic = ProfileView(size: .small)
    
    var posterName = {
        let name = UILabel()
        name.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        name.textColor = .black
        name.text = "유빈"
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = WithYouAsset.backgroundColor.color
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(PostImageCell.self, forCellWithReuseIdentifier: PostImageCell.cellId)
        return collectionView
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        pageControl.pageIndicatorTintColor = WithYouAsset.subColor.color
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.isEnabled = true
        pageControl.allowsContinuousInteraction = true
        pageControl.isUserInteractionEnabled = true
        return pageControl
    }()
    
    
    lazy var likeConfig: UIImage.Configuration = {
        let config = UIImage.SymbolConfiguration(pointSize: 24, weight: .light)
        return config
    }()
    
    lazy var messageConfig: UIImage.Configuration = {
        let config = UIImage.SymbolConfiguration(pointSize: 22, weight: .light)
        return config
    }()
    
    
//    lazy var likeButton: UIButton = {
//        let button = UIButton()
//        let image = UIImage(systemName: "heart",withConfiguration: likeConfig)?.withTintColor(.black, renderingMode: .alwaysOriginal)
//        let filledImage = UIImage(systemName: "heart.fill",withConfiguration: likeConfig)?.withTintColor(.red, renderingMode: .alwaysOriginal)
//        button.setImage(filledImage, for: .selected)
//        button.setImage(image, for: .normal)
//        return button
//    }()
    
    lazy var commentButton: UIButton = {
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
    
//    lazy var likeLabel: UILabel = {
//        let label = UILabel()
//        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 15)
//        label.textColor = .black
//        return label
//    }()
    
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
        label.text = "와와아와아ㅣㄹㅁㄴ이ㅏ러ㅏㅣㅈ더래ㅑㄷ저;ㄹ"
        return label
    }()
    
    override func initUI() {
        [titleLabel, periodLabel, profilePic, posterName, optionButton, profileLineView, postCollectionView, pageControl, commentButton, bookMarkButton, likeCount, contextLabel].forEach{
            self.addSubview($0)
        }
        
    }
    
    override func initLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
        }
        
        profileLineView.snp.makeConstraints {
            $0.top.equalTo(periodLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        profilePic.snp.makeConstraints {
            $0.top.equalTo(profileLineView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
        }
        
        posterName.snp.makeConstraints {
            $0.leading.equalTo(profilePic.snp.trailing).offset(10)
            $0.centerY.equalTo(profilePic)
        }
        
        optionButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-10)
            $0.centerY.equalTo(profilePic)
        }
      
        postCollectionView.snp.makeConstraints {
            $0.top.equalTo(profilePic.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(self.snp.width)
        }
        
        pageControl.snp.makeConstraints {
            $0.top.equalTo(postCollectionView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        
//        likeButton.snp.makeConstraints {
//            $0.centerY.equalTo(pageControl)
//            $0.leading.equalToSuperview().offset(15)
//        }
        
        commentButton.snp.makeConstraints {
            $0.centerY.equalTo(pageControl)
            $0.leading.equalToSuperview().offset(15)
        }
        
        bookMarkButton.snp.makeConstraints {
            $0.centerY.equalTo(pageControl)
            $0.trailing.equalToSuperview().offset(-15)
        }

        contextLabel.snp.makeConstraints {
            $0.top.equalTo(commentButton.snp.bottom).offset(10)
            $0.leading.equalTo(commentButton)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
}

