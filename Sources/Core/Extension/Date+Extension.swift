//
//  Date+Extension.swift
//  Core
//
//  Created by 김도경 on 5/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

extension Date {
    public func getCurrentDateToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: Date()).replacingOccurrences(of: ".", with: "-")
    }
    
    public func tranformToYMD() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from:self)
    }
    
    public func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
    
    // 서버에서는 yyyy-MM-dd 형식으로 전달
    public func toStringForServer() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: self)
    }
}
