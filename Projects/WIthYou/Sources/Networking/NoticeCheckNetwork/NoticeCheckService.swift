//
//  NoticeCheckService.swift
//  WithYou
//
//  Created by 김도경 on 2/11/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class NoticeCheckService : BaseService {
    static let shared = NoticeCheckService()
    override private init(){}
    
    //Notice 체크
    func checkNotice(noticeId: Int, memberId :Int, _ completion : @escaping (NoticeCheckResponse)->Void){
        requestReturnsData(NoticeCheckResponse.self, router: NoticeCheckRouter.checkNotice(noticeId: noticeId, memberId: memberId), completion: completion)
    }
}
