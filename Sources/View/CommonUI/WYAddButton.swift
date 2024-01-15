//
//  WYAddButton.swift
//  WithYou
//
//  Created by 김도경 on 1/12/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import  UIKit

enum SizeOption : Int{
    case big = 50
    case small = 25
}

class WYAddButton: UIButton {
    var size : SizeOption = .big
    
    init(_ size : SizeOption = .big){
        super.init(frame:CGRect.zero)
        self.size = size
        setButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setButton(){
        
        self.layer.cornerRadius = CGFloat(size.rawValue/2)
        self.backgroundColor = UIColor(named:"MainColorDark")
        
        self.snp.makeConstraints{
            $0.width.equalTo(size.rawValue)
            $0.height.equalTo(size.rawValue)
        }
    }
    
}
