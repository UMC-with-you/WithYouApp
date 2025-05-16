//
//  Untitled.swift
//  WithYou
//
//  Created by 배수호 on 4/22/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import UIKit

/// 컬러슬라이더 커스텀 ThumbView (슬라이더 컨트롤러)
final class ThumbView: UIView {
    let centerDot = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    /// Thumb view의 설정을 초기화하는 메서드
    private func setup() {
        let dotSize = CGFloat(40).adjusted
        centerDot.frame = CGRect(x: bounds.midX - dotSize / 2,
                                 y: bounds.midY - dotSize / 2,
                                 width: dotSize,
                                 height: dotSize)
        centerDot.backgroundColor = .white
        centerDot.layer.cornerRadius = dotSize / 2
        centerDot.isUserInteractionEnabled = false
        
        addSubview(centerDot)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        centerDot.center = CGPoint(x: bounds.midX, y: bounds.midY)
    }
}
