//
//  NoticeDataManager.swift
//  WithYou
//
//  Created by 이승진 on 2024/01/18.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift
import UIKit

class NoticeDataManager {
    static let shared = NoticeDataManager()
    
    private var noticeDataArray: [Notice] = []
    
    public var notifier = PublishSubject<Log>()

    func getNoticeData() -> [Notice] {
        return noticeDataArray
    }
    
    func updateNoticeFromServer(noticeResponses: [NoticeListResponse], day:Int) -> [Notice] {
        return responseToNotice(response: noticeResponses, day: day)
    }
    
    func responseToNotice(response : [NoticeListResponse], day : Int) -> [Notice]{
        var option : NoticeOptions
        if day > 0 {
            option = .ing
        } else {
            option = .before
        }
        return response.map{ response in
            var profileImage = ""
            if let url = response.url {
                profileImage = url
            }
            return Notice(noticeID: response.noticeId , profileImage: profileImage, state: option, userName: response.name, noticeContent: response.content, checkNum: response.checkNum)
        }
    }
    
    
    func deleteNotice(noticeId : Int,_ completion : @escaping ()->()) {
        NoticeService.shared.deleteNotice(noticeId: noticeId){ _ in
            completion()
        }
    }
}
