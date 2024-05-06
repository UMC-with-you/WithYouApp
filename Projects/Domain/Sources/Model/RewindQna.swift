//
//  RewindQNA.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct RewindQna : Codable {
    var qnaId : Int
    var questionId : Int
    var content : String
    var answer : String
}
