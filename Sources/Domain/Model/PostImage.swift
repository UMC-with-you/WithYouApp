//
//  PostImage.swift
//  Domain
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct PostImage {
    public var imageId : Int
    public var imageUrl : String
    public var position : Int
    
    public init(imageId: Int, imageUrl: String, position: Int) {
        self.imageId = imageId
        self.imageUrl = imageUrl
        self.position = position
    }
}
