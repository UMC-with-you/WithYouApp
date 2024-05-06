//
//  Posting.swift
//  WithYou
//
//  Created by 김도경 on 1/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public struct Log : Codable, Identifiable {
    var id: Int
    var title : String
    var startDate : String
    var endDate : String
    var status : String
    var imageUrl : String
    
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
    func getTravelPeriod() -> String{
        return startDate + "~" + endDate.dropFirst(4)
    }
    
    //네트워크 통신을 위한 처리
    func asLogRequest() -> [String : String] {
        let dic = [
            "title" : title,
            "startDate" : startDate,
            "endDate" : endDate,
            "localDate" : dateController.currentDateToSendServer()
        ]
        return dic
    }
}



