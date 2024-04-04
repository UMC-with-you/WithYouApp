//
//  BaseUIView.swift
//  WithYou
//
//  Created by 이승진 on 2024/04/04.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

protocol BaseUIProtocol {
    /// view 계층 설정 - ex) view.addSubview()
    func initUI()
    /// Layout 설정 - ex) snapkit
    func initLayout()

}

class BaseUIView: UIView, BaseUIProtocol{

    override init(frame: CGRect) {
        super.init(frame: frame)
        initUI()
        initLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initUI() {}

    func initLayout() {}
}
