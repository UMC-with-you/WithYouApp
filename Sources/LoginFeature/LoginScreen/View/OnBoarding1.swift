//
//  OnBoardingView.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/15.
//  Copyright © 2024 withyou.org. All rights reserved.
//


import SnapKit
import UIKit

final class OnBoarding1: BaseOnBoarding {
    init() {
        super.init(
            title: "우리 여행의 한 페이지",
            description1: "여행 Pod을 만들어",
            description1Bold: NSRange(location: 0, length: 6),
            description2: "함께 여행하는 사람들을 초대해보세요!",
            mockUpImage: UIImage(named: "MockUp")
        )
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
