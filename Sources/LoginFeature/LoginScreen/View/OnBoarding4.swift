//
//  OnBoarding3.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import SnapKit
import UIKit

final class OnBoarding4: BaseOnBoarding {
    init() {
        super.init(
            title: "여행이 끝난 후",
            description1: "Photo Book에서 우리만의 피드를 꾸미고",
            description1Bold: NSRange(location: 0, length: 10),
            description2: "Rewind Tape으로 여행을 추억해요.",
            description2Bold: NSRange(location: 0, length: 11),
            mockUpImage: UIImage(named: "MockUp3")
        )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
