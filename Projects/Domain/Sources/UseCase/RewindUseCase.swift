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
    func createRewind(rewindPostRequest : RewindPostRequest, travelId : Int) -> Single<Void>
    func getOneRewind(travelId : Int, rewindId : Int) -> Single<Rewind>
    func deleteRewind(travelId : Int, rewindId : Int) -> Single<Void>
    func editRewind(rewindEditRequest: RewindEditRequest, travelId: Int) -> Single<Void>
    func getQnaList() -> Single<[RewindQnaListResponse]>
}

final public class DefaultRewindUseCase : RewindUseCase {
    let repository : RewindRepository
    
    public init(repository: RewindRepository) {
        self.repository = repository
    }
    
    public func getAllRewind(travelId: Int, day: Int) -> Single<[Rewind]> {
        repository.getAllRewind(travelId: travelId, day: day)
    }
    
    public func createRewind(rewindPostRequest: RewindPostRequest, travelId: Int) -> Single<Void> {
        repository.createRewind(rewindPostRequest: rewindPostRequest, travelId: travelId)
    }
    
    public func getOneRewind(travelId: Int, rewindId: Int) -> Single<Rewind> {
        repository.getOneRewind(travelId: travelId, rewindId: rewindId)
    }
    
    public func deleteRewind(travelId: Int, rewindId: Int) -> Single<Void> {
        repository.deleteRewind(travelId: travelId, rewindId: rewindId)
    }
    
    public func editRewind(rewindEditRequest: RewindEditRequest, travelId: Int) -> Single<Void> {
        repository.editRewind(rewindEditRequest: rewindEditRequest, travelId: travelId)
    }
    
    public func getQnaList() -> Single<[RewindQnaListResponse]> {
        repository.getQnaList()
    }
    
    
}
