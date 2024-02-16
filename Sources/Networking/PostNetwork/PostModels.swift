//
//  PostModels.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


struct NewPostRequest : Codable {
    var text : String
    var urls : [String]
}

struct EditPostRequest : Codable {
    var content : String
}

struct PostIdResponse : Codable {
    var postId : Int
}

struct OnePostResponse :Codable{
    
}
