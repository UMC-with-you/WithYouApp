//
//  MockLogRepository.swift
//  Data
//
//  Created by 김도경 on 5/30/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

final public class MockLogRepository : LogRepository {
    
    public init(){}
    
    var logs = [
    Log(id: 0, title: "테스트1", startDate: "2024.04.01", endDate: "2024.04.03", status: "ONGOING", imageUrl: ""),
    Log(id: 1, title: "테스트2", startDate: "2024.03.01", endDate: "2024.03.03", status: "BYGONE", imageUrl: ""),
    Log(id: 2, title: "테스트3", startDate: "2024.04.20", endDate: "2024.04.23", status: "UPCOMING", imageUrl: ""),
    Log(id: 3, title: "테스트4", startDate: "2024.04.20", endDate: "2024.04.23", status: "ONGOING", imageUrl: ""),
    Log(id: 4, title: "테스트5", startDate: "2024.04.20", endDate: "2024.04.23", status: "ONGOING", imageUrl: ""),
    ]
    
    public func getAllLogs() -> Single<[Log]> {
        return Single.just((logs))
    }
    
    public func addLog(title: String, startDate: String, endDate: String, image: Data?) -> Single<Int> {
        .just(0)
    }
    
    public func deleteLog(travelId: Int) -> Single<Int> {
        logs = logs.filter{ $0.id != travelId }
        return .just(0)
    }
    
    public func editLog(travelId: Int, title: String?, startDate: String?, endDate: String?, localDate: Date?, image: Data?) -> Single<Int> {
        .just(0)
    }
    
    public func joinLog(inviteCode: String) -> Single<Void> {
        .just(())
    }
    
    public func getAllLogMembers(travelId: Int) -> Single<[Traveler]> {
        .just([Traveler(id: 0, name: "김도경"),Traveler(id: 1, name: "홍길동"),Traveler(id: 2, name: "카리나"),Traveler(id: 3, name: "남궁민수")])
    }
    
    public func getInviteCode(travelId: Int) -> Single<String> {
            .just("test-Invite-Code")
    }
    
    public func leaveLog(travelId: Int, memberId: Int) -> Single<Int> {
        logs = logs.filter{ $0.id != travelId }
        return .just(0)
    }
}
