//
//  PackingItemModels.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


struct PackingItemIdResponse : Codable {
    var packingItemId : Int
}

struct PackingItemCheckResponse : Codable {
    var packingItemId : Int
    var checkboxState: Bool
}

struct PackingItemSetResponse : Codable {
    var packingItemId : Int
    var packerId : Int?
    var checkboxState: Bool
}
