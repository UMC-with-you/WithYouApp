//
//  PackingTableCell.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import SnapKit
import RxCocoa
import RxGesture
import RxSwift
import UIKit

class PackingTableCell: UICollectionViewListCell {
    static let cellId = "PackingTableCell"
    
    var travelers = BehaviorRelay<[Traveler]>(value: [])
    var packingItem : PackingItem?
    //var packingManager : PackingItemManager?
    var travelerImages = [ProfileView]()
    
    var checkCircle = UIImageView(image: WithYouAsset.iconCheckOff.image)
    
    var itemName = {
        let label = UILabel()
        label.textColor = WithYouAsset.mainColorDark.color
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        
        return label
    }()
    
    var imageContainer = UIStackView()
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setConst()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bind(travelers : [Traveler], packingItem : PackingItem/*, manager : PackingItemManager*/){
        self.travelers.accept(travelers)
        self.packingItem = packingItem
        self.itemName.text = packingItem.itemName
        //self.packingManager = manager
        self.setRx()
        self.checkPacker(packerId: packingItem.packerId)
        self.checkCircle.image = packingItem.isChecked ? WithYouAsset.iconCheckOn.image : WithYouAsset.iconCheckOff.image
    }
    
    func setRx(){
        //Check Button
        checkCircle.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
//                PackingItemService.shared.checkItem(packingItemId: self.packingItem!.id){ response in
//                    self.packingManager?.itemChangedNotify.onNext(true)
//                    if self.checkCircle.image == WithYouAsset.iconCheckOn.image {
//                        self.checkCircle.image = WithYouAsset.iconCheckOff.image
//                    } else {
//                        self.checkCircle.image = WithYouAsset.iconCheckOff.image
//                    }
//                }
                
            })
            .disposed(by: disposeBag)
        
        //Image Binding
        travelers.subscribe({ travler in
            self.setPic()
        })
        .disposed(by: disposeBag)
        
        //짐 담당 회원 설정
        travelerImages.forEach{ view in
            view.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: {_ in
//                    PackingItemService.shared.setItemMember(packingItemId: self.packingItem!.id, memberId: view.traveler.id) { response in
//                        self.packingManager?.itemChangedNotify.onNext(true)
//                        self.checkPacker(packerId: response.packerId)
//                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    private func checkPacker(packerId : Int?){
        for image in travelerImages {
            if let id = packerId {
                if image.traveler.id == id {
                    image.profileImage.alpha = 1
                }
            } else {
                image.profileImage.alpha = 0.3
            }
        }
    }
    
    func setUp(){
        [checkCircle, itemName, imageContainer].forEach{
            self.addSubview($0)
        }
    }
    
    private func setPic(){
        // 프로파일 이미지 생성해서 container에 추가
        var arr = [ProfileView]()
        travelers.value.forEach{
            arr.append(ProfileView(size: .small, traveler: $0))
        }
        self.travelerImages = arr
        
        //이미지 추가 전 기존 삭제
        imageContainer.subviews.forEach{
            $0.removeFromSuperview()
        }
        
        travelerImages.forEach{
            imageContainer.addArrangedSubview($0)
        }
    }
    
    
    func setConst(){
        checkCircle.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        itemName.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkCircle.snp.trailing).offset(15)
        }
        
        imageContainer.snp.makeConstraints{
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
    }

}
