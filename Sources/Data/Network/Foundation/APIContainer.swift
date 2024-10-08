//
//  APIContainer.swift
//  WithYou
//
//  Created by 김도경 on 1/31/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct APIContainer<T: Decodable> : Decodable{
    var message : String
    var code : String
    var isSuccess : Bool
    var result : T
}


