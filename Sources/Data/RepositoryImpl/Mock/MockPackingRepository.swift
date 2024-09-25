//
//  MockPackingRepository.swift
//  Data
//
//  Created by 김도경 on 6/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxSwift

public class MockPackingRepository : PackingItemRepository {
    private var items = [PackingItem(id: 0, itemName: "더미더미", isChecked: false)]
    
    public init(){}
    
    public func getItemList(travelId: Int) -> Single<[PackingItem]> {
        .just(items)
    }
    
    public func addItem(travelId: Int, itemName: String) -> Single<Int> {
        let new = PackingItem(id: items.count, itemName: itemName, isChecked: false)
        items.append(new)
        return .just(0)
    }
    
    public func deleteItem(packingItemId: Int) -> Single<Int> {
        self.items = items.filter{ $0.packerId != packingItemId }
        return .just(0)
    }
    
    public func checkItem(packingItemId: Int) -> Single<Bool> {
        for item in items {
            var item = item
            if item.id == packingItemId {
                item.isChecked.toggle()
            }
        }
        return .just(true)
    }
    
    public func setItemMember(packingItemId: Int, memberId: Int) -> Single<Bool> {
        for item in items {
            if item.id == packingItemId {
                var new = item
                new.packerId = memberId
            }
        }
        return .just(true)
    }
    
    
}
