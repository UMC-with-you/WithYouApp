//
//  InviteCodeResponse.swift
//  Data
//
//  Created by 김도경 on 5/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct InviteCodeResponse : Decodable {
    let travelId : Int
    let invitationCode : String
}
