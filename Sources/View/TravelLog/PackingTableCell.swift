//
//  PackingTableCell.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import RxGesture
import RxSwift
import UIKit

class PackingTableCell: UICollectionViewCell {
    
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
        label.textColor = WithYouAsset.subColor.color
        label.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
        
        return label
    }()
    
    var disposeBag = DisposeBag()
    
    override init(frame : CGRect) {
        super.init(frame: .zero)
        self.backgroundColor = .gray
        setUp()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp(){
        [checkCircle, itemName].forEach{
            self.addSubview($0)
        }
        
        checkCircle.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { gesture in
                //ApiManager -> tapped ->
                print("Button Tapped")
            })
            .disposed(by: disposeBag)
    }
    
    func setConst(){
        checkCircle.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.height.equalTo(30)
        }
        
        itemName.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(checkCircle.snp.trailing)
        }
    }

}
