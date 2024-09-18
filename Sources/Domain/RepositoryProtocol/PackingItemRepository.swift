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
    func addItem(travelId : Int, itemName : String) -> Single<Int>
    func deleteItem(packingItemId : Int) -> Single<Int>
    func checkItem(packingItemId: Int) -> Single<Bool>
    func setItemMember(packingItemId : Int, memberId : Int) -> Single<Bool>
}
