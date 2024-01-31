//
//  Model.swift
//  WithYou
//
//  Created by 배수호 on 1/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct testMode: Codable {
    var isSuccess: Bool
    var code: String
    var message: String
    var result: [id]
}

struct id: Codable {
    var travelId: Double
}

