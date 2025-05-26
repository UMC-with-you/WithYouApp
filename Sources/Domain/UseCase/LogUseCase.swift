//
//  LogUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public protocol LogUseCase {
    func getAllLogs() -> Single<[Log]>
    func addLog(title:String, startDate:String, endDate: String, image : Data) -> Single<Void>
    func deleteLog(travelId : Int) -> Single<Int>
    func editLog(travelId : Int, title:String?, startDate:String?, endDate: String?, localDate:Date?, image : Data?) -> Single<Int>
    func joinLog(inviteCode : String) -> Single<Void>
    func getAllLogMembers(travelId : Int) -> Single<[Traveler]>
    func getInviteCode(travelId : Int) -> Single<String>
    func leaveLog(travelId : Int , memberId : Int) -> Single<Int>
}

public final class DefaultLogUseCase : LogUseCase {
    
    let repository : LogRepository
    let s3Repository : S3Repository
    
    public init(repository: LogRepository, s3Repository: S3Repository) {
        self.repository = repository
        self.s3Repository = s3Repository
    }
    
    public func getAllLogs() -> Single<[Log]> {
        repository.getAllLogs()
    }
    
    /**
     * 로그 추가하기
     * 
     * @input
     * - title: 로그 제목
     * - startDate: 여행 시작 날짜 (String 형식)
     * - endDate: 여행 종료 날짜 (String 형식)
     * - image: 로그 대표 이미지 데이터 (선택적) / 없으면 기본 이미지 보여줘야함
     * - 현재 날짜는 repository에서 처리
     * 
     * @output
     * - Single<Int>: 생성된 여행 ID 반환
     * 
     * @기능
     * - 로그 정보를 서버로 전달
     * - 서버에서 URL 주면 해당 URL에 이미지 업로드
     */
    public func addLog(title: String, startDate: String, endDate: String, image: Data) -> Single<Void> {
        // presignedURL 받아오기
        repository.addLog(title: title, startDate: startDate, endDate: endDate)
            .flatMap { url in
                // 이미지 업로드
                return self.s3Repository.uploadS3(url: url, image: image)
            }
    }
    
    public func deleteLog(travelId: Int) -> Single<Int> {
        repository.deleteLog(travelId: travelId)
    }
    
    public func editLog(travelId: Int, title: String?, startDate: String?, endDate: String?, localDate: Date?, image: Data?) -> Single<Int> {
        repository.editLog(travelId: travelId, title: title, startDate: startDate, endDate: endDate, localDate: localDate, image: image)
    }
    
    public func joinLog(inviteCode: String) -> Single<Void> {
        repository.joinLog(inviteCode: inviteCode)
    }
    
    public func getInviteCode(travelId: Int) -> Single<String> {
        repository.getInviteCode(travelId: travelId)
    }
    
    public func getAllLogMembers(travelId: Int) -> Single<[Traveler]> {
        repository.getAllLogMembers(travelId: travelId)
    }
    
    public func leaveLog(travelId: Int, memberId: Int) -> Single<Int> {
        repository.leaveLog(travelId: travelId, memberId: memberId)
    }
}
