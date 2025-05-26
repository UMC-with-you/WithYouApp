//
//  DayController.swift
//  WithYou
//
//  Created by 김도경 on 1/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

public let dateController = DateController.shared

open class DateController {
    public static let shared = DateController()
    
    public let dateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        return formatter
    }()
    
    private init(){}
    
    public func currentDateToSendServer() -> String{
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: Date()).replacingOccurrences(of: ".", with: "-")
    }
    
    public func getDate(_ date : Date) -> String{
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    public func strToDate(_ str : String) -> Date{
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.date(from: str) ?? Date()
    }
    
    public func dateToStr(_ date : Date) -> String {
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    //dday계산 
    public func days(from date: String) -> String {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for : dateController.strToDate(date))
        let targetDate = calendar.startOfDay(for: Date.now)
        
        let date = Calendar.current.dateComponents([.day], from: startDate, to: targetDate).day!
        if date == 0 {
            return "D-Day"
        } else if date < 0 {
            return "D\(date)"
        } else {
            return "Day \(date)"
        }
    }
    
    func daysAsInt(from date: String)-> Int {
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for : dateController.strToDate(date))
        let targetDate = calendar.startOfDay(for: Date.now)
        
        return Calendar.current.dateComponents([.day], from: startDate, to: targetDate).day!    }
}
