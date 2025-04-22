//
//  CGFloat+extension.swift
//  WithYou
//
//  Created by 배수호 on 4/8/25.
//  Copyright © 2025 WithYou.app. All rights reserved.
//

import UIKit

extension CGFloat {
    var adjusted: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.width / 393
        return self * ratio
    }
    
    var adjustedH: CGFloat {
        let ratio: CGFloat = UIScreen.main.bounds.height / 852
        return self * ratio
    }
}

