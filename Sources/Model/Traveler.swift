//
//  Traveler.swift
//  WithYou
//
//  Created by 김도경 on 1/29/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


struct Traveler : Identifiable, Codable{
    var id : Int
    var name : String
    var profilePicture : String
    
    private enum CodingKeys : String, CodingKey{
        case id  = "memberId"
        case name
        case profilePicture  = "imageUrl"
    }
}
