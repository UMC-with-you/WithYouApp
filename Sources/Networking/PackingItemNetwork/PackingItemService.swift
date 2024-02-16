//
//  PackingItemService.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation


class PackingItemService : BaseService {
    static let shared = PackingItemService()
    override private init(){}
    
    //짐 목록 조회
    func getItemList(travelId : Int, _ completion : @escaping ([PackingItem]) -> Void){
        requestReturnsData([PackingItem].self, router: PackingItemRouter.getItemList(travelId: travelId), completion: completion)
    }
    
    //짐 추가
    func addItem(travelId : Int,itemName : String, _ completion : @escaping (PackingItemIdResponse) -> Void){
        requestReturnsData(PackingItemIdResponse.self, router: PackingItemRouter.addItem(travelId: travelId, itemName: itemName), completion: completion)
    }
    
    //짐 삭제 -> travelId 응답
    func deleteItem(packingItemId : Int, _ completion : @escaping (LogIDResponse) -> Void){
        requestReturnsData(LogIDResponse.self, router: PackingItemRouter.deleteItem(packingItemId: packingItemId), completion: completion)
    }
    
    //짐 패킹 토글
    func checkItem(packingItemId : Int, _ completion : @escaping (PackingItemCheckResponse) -> Void){
        requestReturnsData(PackingItemCheckResponse.self, router: PackingItemRouter.checkItem(packingItemId: packingItemId), completion: completion)
    }
    
    //짐 담당 멤버 설정
    func setItemMember(packingItemId : Int, memberId : Int,_ completion : @escaping (PackingItemSetResponse) -> Void ){
        requestReturnsData(PackingItemSetResponse.self, router: PackingItemRouter.setItemMember(packingItemId: packingItemId, itemMemberId: memberId), completion: completion)
    }
}
