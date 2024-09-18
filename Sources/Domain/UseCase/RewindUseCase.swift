//
//  RewindUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol RewindUseCase {
    func getAllRewind(travelId : Int, day : Int) -> Single<[Rewind]>
    func createRewind(day: Int,
                      mvpCandidateId: Int,
                      mood: String,
                      qnaList: [RewindQna],
                      comment: String,
                      travelId: Int) -> Single<Int>
    func getOneRewind(travelId : Int, rewindId : Int) -> Single<Rewind>
    func deleteRewind(travelId : Int, rewindId : Int) -> Single<String>
    func editRewind(mvpCandidateId: Int,
                    mood: String,
                    qnaList: [RewindQna],
                    comment: String,
                    travelId: Int, rewindId: Int) -> Single<String>
    func getQnaList() -> Single<[RewindQna]>
}

final public class DefaultRewindUseCase : RewindUseCase {
    let repository : RewindRepository
    
    public init(repository: RewindRepository) {
        self.repository = repository
    }
    
    public func getAllRewind(travelId: Int, day: Int) -> Single<[Rewind]> {
        repository.getAllRewind(travelId: travelId, day: day)
    }
    
    public func createRewind(day: Int,
                             mvpCandidateId: Int,
                             mood: String,
                             qnaList: [RewindQna],
                             comment: String,
                             travelId: Int) -> Single<Int> {
        repository.createRewind(day: day, mvpCandidateId: mvpCandidateId, mood: mood, qnaList: qnaList, comment: comment, travelId: travelId)
    }
    
    public func getOneRewind(travelId: Int, rewindId: Int) -> Single<Rewind> {
        repository.getOneRewind(travelId: travelId, rewindId: rewindId)
    }
    
    public func deleteRewind(travelId: Int, rewindId: Int) -> Single<String> {
        repository.deleteRewind(travelId: travelId, rewindId: rewindId)
    }
    
    public func editRewind(mvpCandidateId: Int,
                           mood: String,
                           qnaList: [RewindQna],
                           comment: String,
                           travelId: Int, rewindId: Int) -> Single<String> {
        repository.editRewind(mvpCandidateId: mvpCandidateId, mood: mood, qnaList: qnaList, comment: comment, travelId: travelId, rewindId: rewindId)
    }
    
    public func getQnaList() -> Single<[RewindQna]> {
        repository.getQnaList()
    }
    
    
}
