//
//  PackingItemUseCase.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol PackingItemUseCase {
    func getItemList(travelId : Int) -> Single<[PackingItem]>
    func addItem(travelId : Int, itemName : String) -> Single<Void>
    func deleteItem(packingItemId : Int) -> Single<Void>
    func checkItem(packingItemId: Int) -> Single<PackingItemCheckResponse>
    func setItemMember(packingItemId : Int, memberId : Int) -> Single<PackingItemSetResponse>
}

final public class DefaultPackingItemUseCase : PackingItemUseCase {
    let repository : PackingItemRepository
    
    public init(repository: PackingItemRepository) {
        self.repository = repository
    }

    public func getItemList(travelId: Int) -> Single<[PackingItem]> {
        repository.getItemList(travelId: travelId)
    }
    
    public func addItem(travelId: Int, itemName: String) -> Single<Void> {
        repository.addItem(travelId: travelId, itemName: itemName)
    }
    
    public func deleteItem(packingItemId: Int) -> Single<Void> {
        repository.deleteItem(packingItemId: packingItemId)
    }
    
    public func checkItem(packingItemId: Int) -> Single<PackingItemCheckResponse> {
        repository.checkItem(packingItemId: packingItemId)
    }
    
    public func setItemMember(packingItemId: Int, memberId: Int) -> Single<PackingItemSetResponse> {
        repository.setItemMember(packingItemId: packingItemId, memberId: memberId)
    }
}
