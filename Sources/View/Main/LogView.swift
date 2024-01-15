//
//  LogView.swift
//  WithYou
//
//  Created by 김도경 on 1/13/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import SnapKit
import UIKit


class LogView: UIView {
    
    let posting : Posting? = nil
    
    let dDay : String = "D-20"
    let title : String = "Title"
    let date : Date? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        setConst()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        
    }
    
    private func setConst(){
        
    }
    
    
}
