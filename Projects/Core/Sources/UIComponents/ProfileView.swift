//
//  ProfileView.swift
//  WithYou
//
//  Created by 김도경 on 1/29/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import SnapKit
import UIKit

enum ProfileSizeOption : Int{
    case big = 70
    case medium = 40
    case small = 32
    case my = 60
}

class ProfileView: UIView {
    
    var size : ProfileSizeOption
    
    var traveler : Traveler
    
    var profileImage = {
       var image = UIImageView()
        image.layer.cornerRadius = 15
        image.layer.borderWidth = 1
        image.layer.borderColor = WithYouAsset.subColor.color.cgColor
        return image
    }()
    
    init( size : ProfileSizeOption, traveler : Traveler = Traveler(id: 0, name: "김아무개", profilePicture: "없음")){
        self.size = size
        self.traveler = traveler
//        if traveler.name == DataManager.shared.getUserName(){
//            self.profileImage.image = UIImage(data:DataManager.shared.getUserImage())
//        }
        super.init(frame: .zero)
        
        //API 연동 후
        //self.profileImage.image = traveler.profilePicture
        
        self.addSubview(profileImage)
        
        setConst()
    }
    
    private func setConst(){
        self.snp.makeConstraints{
            $0.width.equalTo(size.rawValue + 5)
            $0.height.equalTo(size.rawValue + 5)
        }

        profileImage.snp.makeConstraints{
            $0.width.equalTo(size.rawValue)
            $0.height.equalTo(size.rawValue)
            $0.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
