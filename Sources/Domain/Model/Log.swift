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
    
    public init(id: Int, title: String, startDate: String, endDate: String, status: String, imageUrl: String) {
        self.id = id
        self.title = title
        self.startDate = startDate
        self.endDate = endDate
        self.status = status
        self.imageUrl = imageUrl
    }
    
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
        return startDate + "~" + endDate.dropFirst(5)
    }
}



