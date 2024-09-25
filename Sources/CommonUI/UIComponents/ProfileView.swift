//
//  ProfileView.swift
//  WithYou
//
//  Created by 김도경 on 1/29/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit

public enum ProfileSizeOption : Int{
    case big = 70
    case medium = 40
    case small = 32
    case my = 60
}

public class ProfileView: BaseUIView {
    
    private var size : ProfileSizeOption
    
    public var profileImage = UIImageView()
    
    public var traveler : Traveler?
    
    public init(size : ProfileSizeOption){
        self.size = size
        super.init(frame: .zero)
        //API 연동 후
        //self.profileImage.image = traveler.profilePicture
    }
    
    public func bindTraveler(traveler: Traveler){
        self.traveler = traveler
        if traveler.profilePicture == nil {
            profileImage.image = WithYouAsset.defaultProfilePic.image
        }
    }
    
    public func bindImage(image : UIImage){
        self.profileImage.image = image
    }
    
    public override func initUI() {
        self.addSubview(profileImage)
        self.layer.cornerRadius = CGFloat(size.rawValue / 2)
        self.layer.borderWidth = 1
        self.layer.borderColor = WithYouAsset.pointColor.color.cgColor.copy(alpha: 0.28)
        self.backgroundColor = .white
        self.clipsToBounds = true
    }
    
    public override func initLayout() {
        self.snp.makeConstraints{
            $0.width.equalTo(size.rawValue)
            $0.height.equalTo(size.rawValue)
        }
        
        switch size {
        case .big, .medium :
            profileImage.snp.makeConstraints{
                $0.width.equalTo(size.rawValue - 5)
                $0.height.equalTo(size.rawValue - 5)
                $0.center.equalToSuperview()
            }
        case .my :
            profileImage.snp.makeConstraints{
                $0.width.equalTo(size.rawValue - 1)
                $0.height.equalTo(size.rawValue - 1)
                $0.center.equalToSuperview()
            }
        case .small :
            profileImage.snp.makeConstraints{
                $0.width.equalTo(size.rawValue)
                $0.height.equalTo(size.rawValue)
                $0.center.equalToSuperview()
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
