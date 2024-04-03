//
//  EX.swift
//  WithYou
//
//  Created by 김도경 on 4/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

final class EXVIEW : BaseUIView {
   
    
    override init(frame : CGRect){
        super.init(frame: frame)
        setUpViewProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViewProperty() {
        self.backgroundColor = UIColor(red: 0.969, green: 0.969, blue: 0.969, alpha: 1)
    }
    override func initUI() {
        <#code#>
    }
}
