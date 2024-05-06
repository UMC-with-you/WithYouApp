//
//  PackingItemRepository.swift
//  WithYou
//
//  Created by 김도경 on 5/5/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift

public protocol PackingItemRepository {
    func getItemList(travelId : Int) -> Single<[PackingItem]>
    func addItem(travelId : Int, itemName : String) -> Single<Void>
    func deleteItem(packingItemId : Int) -> Single<Void>
    func checkItem(packingItemId: Int) -> Single<PackingItemCheckResponse>
    func setItemMember(packingItemId : Int, memberId : Int) -> Single<PackingItemSetResponse>
}
