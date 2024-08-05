//
//  String+Extension.swift
//  Core
//
//  Created by 김도경 on 5/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

extension String {
    public func toDate() -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.date(from:self) ?? Date()
    }
    
    //dday계산
    public func getDdays() -> String {
        let date = Calendar.current.dateComponents([.day], from: self.toDate(), to: Date()).day! + 1
        if date == 0 {
            return "D-Day"
        } else if date < 0 {
            return "D\(date)"
        } else {
            return "Day \(date)"
        }
    }
}
