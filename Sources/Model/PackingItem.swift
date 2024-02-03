//
//  PackingItem.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct PackingItem : Codable, Equatable, Identifiable {
    var id : Int
    var itemName : String
    var isChecked : Bool
    
    private enum CodingKeys : String, CodingKey{
        case id = "itemId"
        case itemName
        case isChecked = "checked"
    }
}
