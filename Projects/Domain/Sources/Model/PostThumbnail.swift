//
//  PostThumbnail.swift
//  Domain
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct PostThumbnail : Decodable {
    public var postId : Int
    public var thumbnailUrl : String
}
