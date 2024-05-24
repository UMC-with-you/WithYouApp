//
//  PackingItemRepositoryImpl.swift
//  Data
//
//  Created by 김도경 on 5/19/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Domain
import Foundation
import RxSwift

final public class DefaultPackingItemRepository : PackingItemRepository {
    
    let service = BaseService()
    
    public func getItemList(travelId: Int) -> Single<[PackingItem]> {
        let router = PackingItemRouter.getItemList(travelId: travelId)
        return service.request(GetPackingItemResponseDTO.self, router: router)
    }
    
    public func addItem(travelId : Int, itemName : String) -> Single<Int>{
        let router = PackingItemRouter.addItem(travelId: travelId, itemName: itemName)
        return service.request(DefaultPackingItemResponseDTO.self, router: router).map{ $0.packingItemId }
    }
    
    public func deleteItem(packingItemId : Int) -> Single<Int>{
        let router = PackingItemRouter.deleteItem(packingItemId: packingItemId)
        return service.request(DefaultPackingItemResponseDTO.self, router: router).map{ $0.packingItemId }
    }
    
    public func checkItem(packingItemId: Int) -> Single<Bool>{
        let router = PackingItemRouter.checkItem(packingItemId: packingItemId)
        return service.request(CheckItemResponseDTO.self, router: router).map{ $0.checkboxState }
    }
    
    public func setItemMember(packingItemId : Int, memberId : Int) -> Single<Bool>{
        let router = PackingItemRouter.setItemMember(packingItemId: packingItemId, itemMemberId: memberId)
        return service.request(SetPackingItemResponseDTO.self, router: router).map{ $0.checkboxState }
    }
}
