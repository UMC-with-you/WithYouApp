//
//  Traveler.swift
//  WithYou
//
//  Created by 김도경 on 1/29/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


public struct Traveler : Codable{
    public var id : Int
    public var name : String
    public var profilePicture : String?
    
    public init(id: Int, name: String, profilePicture: String? = nil) {
        self.id = id
        self.name = name
        self.profilePicture = profilePicture
    }
    
    private enum CodingKeys : String, CodingKey{
        case id  = "memberId"
        case name
        case profilePicture  = "imageUrl"
    }
}
