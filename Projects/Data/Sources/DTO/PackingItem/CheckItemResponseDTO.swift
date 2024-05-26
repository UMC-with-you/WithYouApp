//
//  CheckItemResponseDTO.swift
//  Data
//
//  Created by 김도경 on 5/21/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct CheckItemResponseDTO : Decodable {
    let packingItemId : Int
    let checkboxState: Bool
}
