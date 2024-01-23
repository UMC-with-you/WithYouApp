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
    
    public let dateFormatter = DateFormatter()
    
    func getDate(_ date : Date) -> String{
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    func strToDate(_ str : String) -> Date{
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.date(from: str) ?? Date()
    }
    
    func dateToStr(_ date : Date) -> String {
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
    
    //dday계산 
    func days(from date: Date) -> String {
        return "D" + String(Calendar.current.dateComponents([.day], from: date, to: Date()).day! + 1)
    }
}
