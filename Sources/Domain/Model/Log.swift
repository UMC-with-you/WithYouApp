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
    
    /// 오늘 기준 startDate까지 남은 일수 (D-Day)
    public func dDayValue() -> Int? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // 서버에서 받은 date format과 맞춰야 함
        formatter.locale = Locale(identifier: "ko_KR")
        
        guard let start = formatter.date(from: self.startDate) else { return nil }
        let today = Calendar.current.startOfDay(for: Date())
        let target = Calendar.current.startOfDay(for: start)
        
        let components = Calendar.current.dateComponents([.day], from: today, to: target)
        return components.day
    }
}



