//
//  Rewind.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Rewind : Codable{
    var rewindId : Int
    var day : Int //해당 Rewind의 여행 일자
    var writerId : Int
    var mvpCandidateId : Int //MVP member ID
    var mood : String
    var comment : String
    var rewindQnaList : [RewindQna]
    var createdAt : String
    var updatedAt : String
}

