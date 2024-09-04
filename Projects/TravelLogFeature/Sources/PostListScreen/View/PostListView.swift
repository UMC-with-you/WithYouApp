//
//  PostListView.swift
//  TravelLogFeature
//
//  Created by bryan on 7/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import Foundation
import UIKit

public class PostListView : BaseUIView {
    let titleLabel = {
        let label = UILabel()
        label.text = "POST"
        label.textColor = .black
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 20)
        return label
    }()
    
    let topContainerView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
        
    }()
    
    let travelTitle = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
        label.textColor = WithYouAsset.mainColorDark.color
        label.textAlignment = .center
        return label
    }()
    
    let dateTitle = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.medium.font(size: 16)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/3) - 2 , height: (UIScreen.main.bounds.width/3) - 2)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        
        let grid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        grid.register(PostListCell.self, forCellWithReuseIdentifier: PostListCell.cellId)
        grid.showsVerticalScrollIndicator = false
        grid.backgroundColor = .white
        return grid
    }()
    
    let addButton = WYAddButton(.big)
    
    override public func initLayout() {
        topContainerView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.06)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.safeAreaLayoutGuide)
        }
        travelTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(5)
        }
        dateTitle.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalTo(travelTitle.snp.bottom).offset(5)
        }
        
        collectionView.snp.makeConstraints{
            $0.top.equalTo(topContainerView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        addButton.snp.makeConstraints{
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-15)
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
        }
    }
    
    override public func initUI() {
        [topContainerView,collectionView,addButton].forEach{
            self.addSubview($0)
        }
        [travelTitle,dateTitle].forEach {
            topContainerView.addSubview($0)
        }
    }
}
