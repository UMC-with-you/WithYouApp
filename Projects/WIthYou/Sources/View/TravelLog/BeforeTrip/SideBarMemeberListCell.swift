//
//  SideBarMemeberListCell.swift
//  WithYou
//
//  Created by 김도경 on 2/2/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit

class SideBarMemeberListCell: UICollectionViewCell {
    static let cellId = "SideBarMemberListCell"
    
    func bindView(_ bindView : UIView){
        self.addSubview(bindView)
        
        bindView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
