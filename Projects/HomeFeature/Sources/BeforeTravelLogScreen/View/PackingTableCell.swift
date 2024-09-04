//
//  PackingTableCell.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Core
import CommonUI
import Domain
import RxSwift
import UIKit

class PackingTableCell: UICollectionViewListCell {
    static let cellId = "PackingTableCell"
    
    var packingItem : PackingItem?
    var travelers : [Traveler] = []
    
    var checkCircle = UIImageView(image: WithYouAsset.iconCheckOff.image)
    
    var itemName = {
        let label = UILabel()
        label.textColor = WithYouAsset.mainColorDark.color
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        return label
    }()
    
    var imageContainer = {
       let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .trailing
        view.spacing = 7
        view.distribution = .equalSpacing
        return view
    }()
    
    //var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.selectedBackgroundView = UIView()
        setUp()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(travelers : [Traveler], packingItem : PackingItem){
        self.packingItem = packingItem
        self.itemName.text = packingItem.itemName
        self.checkCircle.image = packingItem.isChecked ? WithYouAsset.iconCheckOn.image : WithYouAsset.iconCheckOff.image
        self.travelers = travelers
        setPic()
    }
    
    func setUp(){
        [checkCircle, itemName, imageContainer].forEach{
            self.addSubview($0)
        }
    }
    
    private func setPic(){
        for traveler in travelers {
            let view = ProfileView(size: .small)
            view.bindTraveler(traveler: traveler)
            imageContainer.addArrangedSubview(view)
        }
        
        
        // 프로파일 이미지 생성해서 container에 추가
//        var arr = [ProfileView]()
//        travelers.value.forEach{
//            arr.append(ProfileView(size: .small, traveler: $0))
//        }
//        self.travelerImages = arr
//        
//        //이미지 추가 전 기존 삭제
//        imageContainer.subviews.forEach{
//            $0.removeFromSuperview()
//        }
//        
//        travelerImages.forEach{
//            imageContainer.addArrangedSubview($0)
//        }
    }
    
    
    func setConst(){

        checkCircle.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        itemName.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkCircle.snp.trailing).offset(10)
        }
        
        imageContainer.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
           return contentView.systemLayoutSizeFitting(CGSize(width: self.bounds.size.width, height: 40))
       }
}
