//
//  RewindRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol RewindRepository {
    func getAllRewind(travelId : Int, day : Int) -> Single<[Rewind]>
    func createRewind(rewindPostRequest : RewindPostRequest, travelId : Int) -> Single<Void>
    func getOneRewind(travelId : Int, rewindId : Int) -> Single<Rewind>
    func deleteRewind(travelId : Int, rewindId : Int) -> Single<Void>
    func editRewind(rewindEditRequest: RewindEditRequest, travelId: Int) -> Single<Void>
    func getQnaList() -> Single<[RewindQnaListResponse]>
}
