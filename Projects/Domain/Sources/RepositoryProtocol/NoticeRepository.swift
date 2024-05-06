//
//  NoticeRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol NoticeRepository {
    func createNotice(info: Dictionary<String,Any>, memberId : Int, logId: Int) -> Single<Void>
    func editNotice(notice: EditNoiceRequest) -> Single<Void>
    func getOneNotice(noticeId : Int) -> Single<Void>
    func deleteNotice(noticeId : Int) -> Single<Void>
    func getAllNoticeByLog(travelId : Int) -> Single<Void>
    func getAllNoticeByDate(travelId : Int) -> Single<Void>
    func checkNotice() -> Single<Void>
}
