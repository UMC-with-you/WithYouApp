
//  BaseUIView.swift
//  WithYou
//
//  Created by 김도경 on 4/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public protocol BaseUIProtocol {
    /// view 계층 설정 - ex) view.addSubview()
    func initUI()
    /// Layout 설정 - ex) snapkit
    func initLayout()
}

open class BaseUIView: UIView, BaseUIProtocol{
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initLayout()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initUI() {}
    
    open func initLayout() {}
}
