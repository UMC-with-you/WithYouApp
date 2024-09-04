//
//  GridTravelLogView.swift
//  WithYou
//
//  Created by 김도경 on 5/3/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import UIKit

class TravelLogView : BaseUIView {
    let header = TopHeader()
    
    let searchBar = {
       let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = WithYouAsset.subColor.color.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let searchIcon = UIImageView(image: WithYouAsset.searchIcon.image)
    
    let searchField = {
        let field = UITextField()
        field.placeholder = "검색어를 입력해주세요"
        field.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        field.textColor = WithYouAsset.subColor.color
        field.borderStyle = .none
        return field
    }()
    
    let sortIcon = UIImageView(image: WithYouAsset.sortIcon.image)
    
    lazy var gridView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 2 - 20, height: 225)
        layout.minimumInteritemSpacing = 10
        
        let grid = UICollectionView(frame: .zero, collectionViewLayout: layout)
        grid.register(LogCollectionViewCell.self, forCellWithReuseIdentifier: LogCollectionViewCell.cellId)
        grid.showsVerticalScrollIndicator = false
        return grid
    }()
    
    let button = WYAddButton()
    
    override func initUI() {
        [header,searchBar,sortIcon,gridView,button].forEach {
            self.addSubview($0)
        }
        [searchIcon,searchField].forEach{
            searchBar.addSubview($0)
        }
    }
    
    override func initLayout() {
        header.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
        }
        sortIcon.snp.makeConstraints{
            $0.width.height.equalTo(28)
            $0.centerY.equalTo(searchBar.snp.centerY)
            $0.trailing.equalToSuperview().offset(-15)
        }
        //SearchBar
        searchBar.snp.makeConstraints{
            $0.top.equalTo(header.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalTo(sortIcon.snp.leading).offset(-10)
            $0.height.equalTo(40)
        }
        searchIcon.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.width.height.equalTo(24)
            $0.centerY.equalToSuperview()
        }
        searchField.snp.makeConstraints{
            $0.leading.equalTo(searchIcon.snp.trailing).offset(10)
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerY.equalToSuperview()
        }
        
        gridView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(searchBar.snp.bottom).offset(15)
            $0.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        button.snp.makeConstraints{
            $0.bottom.equalTo(self.safeAreaLayoutGuide).offset(-15)
            $0.trailing.equalToSuperview().offset(-15)
        }
    }
    
}
