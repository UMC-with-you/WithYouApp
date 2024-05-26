//
//  PackingItem.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct PackingItem : Codable, Equatable, Identifiable {
    public var id : Int
    public var itemName : String
    public var packerId : Int?
    public var isChecked : Bool
    
    private enum CodingKeys : String, CodingKey{
        case id = "itemId"
        case itemName
        case packerId
        case isChecked = "checked"
    }
}
