//
//  RewindRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/24/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public final class DefaultRewindRepository : RewindRepository {
    
    let service = BaseService()
    
    public func getAllRewind(travelId: Int, day: Int) -> Single<[Rewind]> {
        let router = RewindRouter.getAllRewind(travelId: travelId, day: day)
        return service.request(GetAllRewindResponseDTO.self, router: router)
    }
    
    public func createRewind(day: Int,
                             mvpCandidateId: Int,
                             mood: String,
                             qnaList: [RewindQna],
                             comment: String,
                             travelId: Int) -> Single<Int> {
        
        var list = [RewindQnaRequestDTO]()
        for qna in qnaList{
            list.append(RewindQnaRequestDTO(questionId: qna.questionId, answer: qna.content))
        }

        let dto = CreateRewindRequestDTO(day: day,
                                         mvpCandidateId: mvpCandidateId,
                                         mood: mood,
                                         qnaList: list,
                                         comment: comment)
        
        let router = RewindRouter.createRewind(rewindDTO: dto, travelId: travelId)
        return service.requestWithImage(CreateRewindResponseDTO.self, router: router).map{ $0.rewindId }
    }
    
    public func getOneRewind(travelId: Int, rewindId: Int) -> Single<Rewind> {
        let router = RewindRouter.getOneRewind(travelId: travelId, rewindId: rewindId)
        return service.request(GetOneRewindResponseDTO.self, router: router)
    }
    
    public func deleteRewind(travelId: Int, rewindId: Int) -> Single<String> {
        let router = RewindRouter.deleteRewind(travelId: travelId, rewindId: rewindId)
        return service.request(String.self, router: router).map{ _ in "Success" }
    }
    
    public func editRewind(mvpCandidateId: Int,
                           mood: String,
                           qnaList: [RewindQna],
                           comment: String,
                           travelId: Int, rewindId: Int) -> Single<String> {
        var list = [RewindQnaRequestDTO]()
        for qna in qnaList{
            list.append(RewindQnaRequestDTO(questionId: qna.questionId, answer: qna.content))
        }
        let dto = EditRewindRequestDTO(mvpCandidateId: mvpCandidateId, mood: mood, qnaList: list, comment: comment)
        
        let router = RewindRouter.editRewind(rewindDTO: dto, travelId: travelId, rewindId: rewindId)
        return service.requestWithImage(EditRewindReponseDTO.self, router: router).map{ $0.updatedAt }
    }
    
    public func getQnaList() -> Single<[RewindQna]> {
        let router = RewindRouter.getQnaList
        return service.request(GetQnaListResponseDTO.self, router: router).map{ list in
            list.map{$0.toDomain()}
        }
    }
}
