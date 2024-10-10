//
//  SeparatorView.swift
//  WithYou
//
//  Created by 김도경 on 1/15/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public class SeparatorView: UIView {

    public init() {
        super.init(frame: .zero)
        setUp()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUp() {
        backgroundColor = .gray
    }

    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height:0.1)
    }
}
