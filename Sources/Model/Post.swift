//
//  Post.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


struct Post : Codable {
    var travelId : Int
    var title : String
    var startDate : String
    var endDate : String
    var status : String
    var imageUrl : String
}
