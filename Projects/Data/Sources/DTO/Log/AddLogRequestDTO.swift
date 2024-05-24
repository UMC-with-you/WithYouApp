//
//  AddLogRequestDTO.swift
//  Data
//
//  Created by 김도경 on 5/10/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


public struct AddLogRequestDTO : Encodable {
    public let title : String
    public let startDate : String
    public let endDate : String
    public let localDate : String
}
