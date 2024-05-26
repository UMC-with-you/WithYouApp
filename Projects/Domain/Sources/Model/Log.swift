//
//  Posting.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Log : Codable, Identifiable {
    public var id: Int
    public var title : String
    public var startDate : String
    public var endDate : String
    public var status : String
    public var imageUrl : String
    
    private enum CodingKeys : String, CodingKey{
        case id = "travelId"
        case title
        case startDate
        case endDate
        case status
        case imageUrl
    }
}

extension Log {
    public func getTravelPeriod() -> String{
        return startDate + "~" + endDate.dropFirst(4)
    }
}



