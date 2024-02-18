//
//  RewindService.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

class RewindService : BaseService {
    static let shared = RewindService()
    override private init(){}
    
    //Rewind 리스트 조회
    func getAllRewind(travelId : Int, day : Int, _ completion : @escaping (Any)->Void){
        requestReturnsData([Rewind].self, router: RewindRouter.getAllRewind(travelId: travelId, day: day), completion: completion)
    }
    
    //Rewind 생성
    func postRewind(rewindPostRequest : RewindPostRequest, travelId : Int,_ completion : @escaping (RewindResponse)->Void){
        requestReturnsData(RewindResponse.self, router: RewindRouter.postRewind(rewindPostRequest: rewindPostRequest, travelId: travelId), completion: completion)
    }
    
    //Rewind 단건 조회
    func getOneRewind(travelId : Int, rewindId : Int,_ completion : @escaping (Any)->Void){
        requestReturnsData(Rewind.self, router: RewindRouter.getOneRewind(travelId: travelId, rewindId: rewindId), completion: completion)
    }
    
    //Rewind 삭제
    func deleteRewind(travelId : Int, rewindId : Int , _ completion : @escaping (Any)->Void){
        requestReturnsNoData(router: RewindRouter.deleteRewind(travelId: travelId, rewindId: rewindId), completion: completion)
    }
    
    //Rewind 수정
    func editRewind(rewindEditRequest: RewindEditRequest, travelId: Int, rewindId : Int,_ completion : @escaping (RewindEditResponse)->Void ){
        requestReturnsData(RewindEditResponse.self, router: RewindRouter.editRewind(rewindPostRequest: rewindEditRequest, travelId: travelId, rewindId: rewindId), completion: completion)
    }
    
    //Rewind Qna 가져오기
    func getQnaList(_ completion : @escaping ([RewindQnaListResponse])->Void){
        requestReturnsData([RewindQnaListResponse].self, router: RewindRouter.getQnaList, completion: completion)
    }
}
