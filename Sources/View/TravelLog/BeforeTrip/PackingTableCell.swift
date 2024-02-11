//
//  PackingTableCell.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import RxCocoa
import RxGesture
import RxSwift
import UIKit

class PackingTableCell: UICollectionViewCell {
    
    static let cellId = "PackingTableCell"
    
    var travlers = BehaviorRelay<[Traveler]>(value: [])
    
    var travelerImages = [ProfileView]()
    
    var checkCircle = {
       let circle = UIView()
        circle.backgroundColor = .white
        circle.layer.cornerRadius = 16
        circle.layer.borderColor = WithYouAsset.subColor.color.cgColor
        circle.layer.borderWidth = 2.0
        return circle
    }()
    
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
        setRx()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func bindTravlers(travelers : [Traveler]){
        self.travlers.accept(travelers)
    }
    
    func setRx(){
        //Check Button
        checkCircle.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                //ApiManager -> tapped ->
                print("Button Tapped")
            })
            .disposed(by: disposeBag)
        //Image Binding
        travlers.subscribe({ travler in
            self.setPic()
        })
        .disposed(by: disposeBag)
        
        //
        travelerImages.forEach{
            $0.rx.tapGesture()
                .when(.recognized)
                .subscribe(onNext: {_ in 
                    print("Tapped")
                })
                .disposed(by: disposeBag)
        }
    }
    
    func setUp(){
        
        [checkCircle, itemName, imageContainer].forEach{
            self.addSubview($0)
        }
        
        for _ in 0..<4{
            let pv = ProfileView(size: .small)
            travelerImages.append(pv)
            imageContainer.addArrangedSubview(pv)
        }
    }
    
    private func setPic(){
        travelerImages.enumerated().forEach{ count, traveler  in
            //API통해 이미지 받아오기
            //traveler.profileImage.image = travlers.value[count].profilePicture
            traveler.profileImage.image = WithYouAsset.homeIcon.image
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
