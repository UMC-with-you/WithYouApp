//
//  Posting.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct Log : Codable, Identifiable {
    var id: Int
    var title : String
    var startDate : String
    var endDate : String
    var imageUrl : String
    
    private enum CodingKeys : String, CodingKey{
        case id = "travelId"
        case title
        case startDate
        case endDate
        case imageUrl
    }
}

extension Log {
    func getTravelPeriod() -> String{
        return startDate + "~" + endDate.dropFirst(4)
    }
}

