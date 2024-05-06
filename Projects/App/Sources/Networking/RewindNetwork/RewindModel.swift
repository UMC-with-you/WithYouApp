//
//  RewindModel.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct RewindResponse : Codable {
    var rewindId : Int
    var createdAt : String
}

public struct RewindEditRequest : Codable {
    var mvpCandidateId : Int
    var mood : String
    var qnaList :[RewindQnaPostRequest]
    var comment : String
}

public struct RewindEditResponse : Codable {
    var rewindId : Int
    var createdAt : String
    var updatedAt : String
}

public struct RewindPostRequest : Codable{
    var day : Int
    var mvpCandidateId : Int
    var mood : String
    var qnaList :[RewindQnaPostRequest]
    var comment : String
}

public struct RewindQnaPostRequest : Codable {
    var questionId : Int
    var answer : String
}

public struct RewindQnaListResponse : Codable {
    var id : Int
    var content : String
}
