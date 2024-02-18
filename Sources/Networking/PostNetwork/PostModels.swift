//
//  PostModels.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit


struct NewPostStruct  {
    var text : String
    var mediaList : [UIImage]
}
struct NewPostRequest : Codable {
    var text : String
    var mediaList : [String]
}

struct EditPostRequest : Codable {
    var text : String
    var newPositions : [String :  Int]
}

struct PostIdResponse : Codable {
    var postId : Int
}

struct OnePostResponse :Codable{
    var postId : Int
    var memberId : Int
    var text : String
    var postMediaDTO :[PostMediaDTO]
}

struct PostMediaDTO : Codable {
    var postMediaId : Int
    var url : String
    var position : Int
}
