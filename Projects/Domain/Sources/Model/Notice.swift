//
//  Notice.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public struct Notice : Codable {
    public let noticeID : Int
    public let profileImage: String
    public let state : NoticeOptions
    public let userName: String
    public let noticeContent: String
    public let checkNum : Int
    
    public init(noticeID: Int, profileImage: String, state: NoticeOptions, userName: String, noticeContent: String, checkNum: Int) {
        self.noticeID = noticeID
        self.profileImage = profileImage
        self.state = state
        self.userName = userName
        self.noticeContent = noticeContent
        self.checkNum = checkNum
    }
}
