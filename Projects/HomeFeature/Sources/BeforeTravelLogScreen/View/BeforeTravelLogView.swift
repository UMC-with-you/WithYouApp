//
//  BeforeTravelLogView.swift
//  HomeFeature
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import Foundation
import UIKit
import SnapKit

public class BeforeTravelLogView : BaseUIView {
    //D-day
    let day = {
        let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 32)
        label.textColor = .black
        return label
    }()
    
    //Log title
    let logTitle = {
       let label = UILabel()
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 20)
        label.textColor = .black
        return label
    }()
    
    //NoticeView 그림자
    let backGround = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        return view
    }()
    
    //Notice
    let noticeView = NoticeView()
    
    //Packing Together
    let packingContainer = {
        let container = UIView()
        container.backgroundColor = .white
        container.layer.borderColor = WithYouAsset.subColor.color.cgColor
        container.layer.borderWidth = 1.0
        container.layer.cornerRadius = 15
        container.clipsToBounds = true
        return container
    }()
    
    let packingHeader = {
        let section = TwoComponentLineView("Packing Together", imageView: UIImageView(image: WithYouAsset.packingIcon.image))
        section.changeConst {
            section.imageView.snp.updateConstraints{
                $0.width.height.equalTo(32)
            }
        }
        section.label.font = WithYouFontFamily.Pretendard.semiBold.font(size: 18)
        return section
    }()
    
    var packingListView : UICollectionView! = nil
    
    let addItemContainer = {
       let uv = UIView()
        uv.backgroundColor = .systemGray5
        uv.layer.cornerRadius = 10
        return uv
    }()
    
    let textField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.placeholder = "짐 추가하기"
        textField.font = WithYouFontFamily.Pretendard.semiBold.font(size: 16)
        textField.textColor = WithYouAsset.mainColorDark.color
        return textField
    }()
    
    let addItemButton = WYAddButton(.small)
    
    var itemContainerTopConstarint : Constraint?
    
    override public func initUI() {
        // Create list layout
        var layoutConfig = UICollectionLayoutListConfiguration(appearance: .plain)
        layoutConfig.showsSeparators = false
        let listLayout = UICollectionViewCompositionalLayout.list(using: layoutConfig)

        self.packingListView = UICollectionView(frame: CGRect(x: 0, y: 0, width: packingHeader.frame.width, height: 0), collectionViewLayout: listLayout)
        packingListView.allowsMultipleSelection = true
        packingListView.register(PackingTableCell.self, forCellWithReuseIdentifier: PackingTableCell.cellId)
        
        [day, logTitle, backGround, noticeView, packingContainer,addItemContainer].forEach{
            self.addSubview($0)
        }
        
        [packingHeader,packingListView].forEach{
            packingContainer.addSubview($0)
        }
        
        [textField, addItemButton].forEach{
            addItemContainer.addSubview($0)
        }
    }
    
    override public func initLayout() {
        day.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-15)
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(10)
        }
        
        logTitle.snp.makeConstraints{
            $0.leading.equalTo(day)
            $0.top.equalTo(day.snp.bottom).offset(20)
        }
        
        self.addUnderline(to: logTitle, thickness: 7, color: WithYouAsset.underlineColor.color)
        
        //NoticeView
        backGround.snp.makeConstraints{
            $0.edges.equalTo(noticeView)
        }
        
        noticeView.snp.makeConstraints{
            $0.top.equalTo(logTitle.snp.bottom).offset(30)
            $0.leading.equalTo(day)
            $0.trailing.equalToSuperview().offset(-15)
        }
        
        //PackingBox
        packingContainer.snp.makeConstraints{
            $0.width.equalTo(noticeView)
            $0.top.equalTo(noticeView.snp.bottom).offset(35)
            $0.height.equalToSuperview().multipliedBy(0.25)
            $0.centerX.equalToSuperview()
        }
        packingHeader.snp.makeConstraints{
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(packingContainer).offset(10)
            $0.trailing.equalTo(packingContainer).offset(-10)
            $0.height.equalTo(50)
        }
        packingListView.snp.makeConstraints{
            $0.leading.trailing.equalTo(packingHeader)
            $0.bottom.equalTo(packingContainer).offset(-20)
            $0.top.equalTo(packingHeader.snp.bottom).offset(10)
        }
        
        //AddItem
        addItemContainer.snp.makeConstraints{
            $0.width.equalTo(packingContainer)
            self.itemContainerTopConstarint = $0.top.equalTo(packingContainer.snp.bottom).offset(15).constraint
            $0.centerX.equalToSuperview()
            $0.height.equalTo(50)
        }
        textField.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(10)
            $0.trailing.equalTo(addItemButton.snp.leading).offset(-10)
        }
        addItemButton.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
        }
        
        //For CollectionView
    }
}

extension BeforeTravelLogView {
    public func moveTextField(_ layout : UIKeyboardLayoutGuide){
        self.itemContainerTopConstarint?.deactivate()
        self.addItemContainer.snp.makeConstraints{
            self.itemContainerTopConstarint =  $0.top.equalTo(layout).offset(-50).constraint
        }
    }
}
