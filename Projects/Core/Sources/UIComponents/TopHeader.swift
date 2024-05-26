//
//  TopHeader.swift
//  WithYou
//
//  Created by 김도경 on 1/9/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit
import SnapKit

public final class TopHeader : UIView {

    let logo = UIImageView(image: UIImage(named: "Logo"))
    let message = UIImageView(image: UIImage(named: "MessageIcon"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
    private func setConst(){
        self.snp.makeConstraints {
            $0.height.equalTo(100)
            $0.width.equalTo(UIScreen.main.bounds.width)
        }
        
        logo.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-10)
            $0.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(15)
        }
        
        message.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(25)
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-15)
        }
    
    }

    private func setup() {
        addSubview(logo)
        addSubview(message)

    }
}
