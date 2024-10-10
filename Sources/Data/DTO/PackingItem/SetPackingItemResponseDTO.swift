//
//  SetPackingItemResponseDTO.swift
//  Data
//
//  Created by 김도경 on 5/23/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//


struct SetPackingItemResponseDTO : Decodable {
    var packingItemId : Int
    var packerId : Int?
    var checkboxState: Bool
}
