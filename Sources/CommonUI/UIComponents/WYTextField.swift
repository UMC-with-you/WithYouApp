//
//  WYTextField.swift
//  WithYou
//
//  Created by 김도경 on 4/20/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public class WYTextField : UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .roundedRect
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 15
        self.layer.borderColor = WithYouAsset.subColor.color.cgColor
        self.layer.masksToBounds = true
        self.font = WithYouFontFamily.Pretendard.regular.font(size: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func editStarted(){
        self.layer.borderColor = WithYouAsset.mainColorDark.color.cgColor
    }
}
