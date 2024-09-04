//
//  MockNoticeRepository.swift
//  Data
//
//  Created by 김도경 on 6/1/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import Foundation
import RxSwift

public class MockNoticeRepository : NoticeRepository {
    
    var notices = [Notice(noticeID: 0, profileImage: "", state: .always, userName: "테스트", noticeContent: "테스트\(0)sadfewfsfwefasdfwefsdfweffsefwesfwaefafedwsfedfwedfgdfgergvzdregdzfgerdzfxgedrzgderzgzredgredfbhgt", checkNum: 0,didUserChecked: false),
                   Notice(noticeID: 1, profileImage: "", state: .always, userName: "테스트", noticeContent: "테스트\(1)sad", checkNum: 0, didUserChecked: false)]
    
    public init(){}
    
    public func createNotice(state: Int, content: String, memberId: Int, logId: Int) -> Single<Int> {
        notices.append(Notice(noticeID: notices.count, profileImage: "", state: .always, userName: "테스트", noticeContent: "테스트\(notices.count):\(content)", checkNum: 0, didUserChecked: false))
        return Single.just(0)
    }
    
    public func editNotice(noticeId: Int, state: Int, content: String) -> Single<Int> {
        var noticeToEdit = notices.filter{ $0.noticeID == noticeId}
        noticeToEdit[0].noticeContent = content
        return Single.just(0)
    }
    
    public func getOneNotice(noticeId: Int) -> Single<Int> {
        return Single.just(0)
    }
    
    public func deleteNotice(noticeId: Int) -> Single<Int> {
        self.notices = notices.filter{ $0.noticeID != noticeId }
        return Single.just(0)
    }
    
    public func getAllNotice(travelId: Int, day: Int) -> Single<[Notice]> {
        return Single.just(notices)
    }
    
    public func checkNotice(noticeId: Int, memberId: Int) -> Single<Int> {
        for i in 0..<notices.count{
            if notices[i].noticeID == noticeId {
                notices[i].didUserChecked.toggle()
                if notices[i].didUserChecked {
                    notices[i].checkNum += 1
                } else {
                    notices[i].checkNum -= 1
                }
            }
        }
        return Single.just(0)
    }
}
