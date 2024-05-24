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
    func addItem(travelId : Int, itemName : String) -> Single<Int>
    func deleteItem(packingItemId : Int) -> Single<Int>
    func checkItem(packingItemId: Int) -> Single<Bool>
    func setItemMember(packingItemId : Int, memberId : Int) -> Single<Bool>
}

final public class DefaultPackingItemUseCase : PackingItemUseCase {
    let repository : PackingItemRepository
    
    public init(repository: PackingItemRepository) {
        self.repository = repository
    }

    public func getItemList(travelId: Int) -> Single<[PackingItem]> {
        repository.getItemList(travelId: travelId)
    }
    
    public func addItem(travelId: Int, itemName: String) -> Single<Int> {
        repository.addItem(travelId: travelId, itemName: itemName)
    }
    
    public func deleteItem(packingItemId: Int) -> Single<Int> {
        repository.deleteItem(packingItemId: packingItemId)
    }
    
    public func checkItem(packingItemId: Int) -> Single<Bool> {
        repository.checkItem(packingItemId: packingItemId)
    }
    
    public func setItemMember(packingItemId: Int, memberId: Int) -> Single<Bool> {
        repository.setItemMember(packingItemId: packingItemId, memberId: memberId)
    }
}
