//
//  OnBoarding1.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import SnapKit
import UIKit

final class OnBoarding2: BaseOnBoarding {
    init() {
        super.init(
            title: "여행 전",
            description1: "Notice에서 중요한 사항들을 공유하고,",
            description1Bold: NSRange(location: 0, length: 6),
            description2: "with Item에서 공동의 짐을 함께 챙겨요!",
            description2Bold: NSRange(location: 0, length: 9),
            mockUpImage: UIImage(named: "MockUp1")
        )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
