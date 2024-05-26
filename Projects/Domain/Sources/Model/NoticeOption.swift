//
//  NoticeOption.swift
//  WithYou
//
//  Created by 김도경 on 2/7/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public enum NoticeOptions : Int, Codable  {
    case before = 0
    case ing = 1
    case always = 2
}

extension NoticeOptions{
    public var text : String {
        switch self{
        case .before:
            return "여행 전에만"
        case .ing:
            return "여행 중"
        case .always :
            return "전체 기간"
        }
    }
}
