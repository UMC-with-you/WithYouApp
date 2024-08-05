//
//  SideBarMemberCell.swift
//  HomeFeature
//
//  Created by 김도경 on 6/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

class SideBarMemberCell: UITableViewCell {
    static let cellId = "SideBarMemberCell"
    
    func bindView(_ bindView : UIView){
        self.addSubview(bindView)
        
        bindView.snp.makeConstraints{
            $0.width.height.equalToSuperview()
            $0.center.equalToSuperview()
        }
    }
}
