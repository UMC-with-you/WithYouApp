//
//  Notice.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

public struct Notice : Codable {
    var noticeID : Int
    var profileImage: String
    var state : NoticeOptions
    var userName: String
    var noticeContent: String
    var checkNum : Int
}

extension Notice {
    
    func asEditNoticeRequest() -> [String:Any]{
        let state = {
            switch self.state{
            case .before : return 0
            case .ing : return 1
            case .always : return 2
            }
        }
        let dic = [
            "noticeId" : noticeID,
            "state" : state,
            "content" : noticeContent
        ] as [String : Any]
        return dic
    }
}
