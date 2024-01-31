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
    var text : String
    var startDate : String
    var endDate : String
    var media : URL
}

extension Log {
    func getTravelPeriod() -> String{
        return startDate + "~" + endDate.dropFirst(4)
    }
}

