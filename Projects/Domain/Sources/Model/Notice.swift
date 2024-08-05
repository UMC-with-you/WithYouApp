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
    public var state : NoticeOptions
    public let userName: String
    public var noticeContent: String
    public var checkNum : Int
    public var didUserChecked : Bool
    
    public init(noticeID: Int, profileImage: String, state: NoticeOptions, userName: String, noticeContent: String, checkNum: Int, didUserChecked: Bool) {
        self.noticeID = noticeID
        self.profileImage = profileImage
        self.state = state
        self.userName = userName
        self.noticeContent = noticeContent
        self.checkNum = checkNum
        self.didUserChecked = didUserChecked
    }
}
