//
//  PostingComments.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct PostingComments : Identifiable,Codable {
    let id: Int
    let postId : Int
    var text : String
}

struct GettingComments : Codable{
    let nickName : String
    let text : String
}
