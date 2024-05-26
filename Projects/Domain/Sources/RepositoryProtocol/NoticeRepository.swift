//
//  NoticeRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol NoticeRepository {
    func createNotice(state: Int, content: String, memberId: Int, logId: Int) -> Single<Int>
    func editNotice(noticeId : Int, state: Int, content : String) -> Single<Int>
    func getOneNotice(noticeId : Int) -> Single<Int>
    func deleteNotice(noticeId : Int) -> Single<Int>
    func getAllNotice(travelId : Int, day : Int) -> Single<[Notice]>
    func checkNotice(noticeId : Int, memberId : Int) -> Single<Int>
}
