//
//  UIColor+Extension.swift
//  WithYou
//
//  Created by 배수호 on 4/22/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import UIKit

extension UIColor {
    /// UIColor에서 RGB 값을 추출하는 메서드
    func getRGBComponents() -> (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0

        let success = self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return success ? (r, g, b, a) : nil
    }
}
