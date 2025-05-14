//
//  OnBoarding2.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import SnapKit
import UIKit

final class OnBoarding3: BaseOnBoarding {
    init() {
        super.init(
            title: "오늘의 여행은 어떠셨나요?",
            description1: "오늘의 여행 Rewind를 통해 여행을 기록하고",
            description1Bold: NSRange(location: 0, length: 13),
            description2: "오늘의 한마디를 전해보세요.",
            description2Bold: NSRange(location: 0, length: 7),
            mockUpImage: UIImage(named: "MockUp2")
        )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
