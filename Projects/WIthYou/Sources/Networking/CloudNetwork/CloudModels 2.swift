//
//  CloudModels.swift
//  WithYou
//
//  Created by 김도경 on 2/18/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct CloudRequest : Codable {
    var date : String
    var travelId : Int
}

struct CloudResponse : Codable {
    var date : String
    var urlList : [String]
}
