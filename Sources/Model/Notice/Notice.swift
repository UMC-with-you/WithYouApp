//
//  Notice.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import UIKit

struct Notice : Codable {
    var noticeID : Int
    var profileImage: String
    var state : NoticeOptions
    var userName: String
    var noticeContent: String
}

extension Notice {
//    func responseToNotice(response : [NoticeListResponse]) -> [Notice]{
//        return response.map{ _ in
//            Notice(noticeID: <#T##Int#>, profileImage: <#T##String#>, state: <#T##NoticeOptions#>, userName: <#T##String#>, noticeContent: <#T##String#>)
//        }
//    }
    
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
