//
//  RewindQNA.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct RewindQna : Codable {
    public var qnaId : Int
    public var questionId : Int
    public var content : String
    public var answer : String
    
    public init(qnaId: Int, questionId: Int, content: String, answer: String) {
        self.qnaId = qnaId
        self.questionId = questionId
        self.content = content
        self.answer = answer
    }
}
