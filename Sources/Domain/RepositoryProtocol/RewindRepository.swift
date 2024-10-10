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
