//
//  PackingItemManager.swift
//  WithYou
//
//  Created by 김도경 on 2/15/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import RxSwift
import Foundation

class PackingItemManager {
    private var itemList = [PackingItem]()
    
    var itemChangedNotify = PublishSubject<Bool>()
    
    func updateItemFromServer(travelId: Int, _ completion : @escaping ()->()) {
        PackingItemService.shared.getItemList(travelId: travelId) { response in
            self.itemList = response
            completion()
        }
    }
    
    func getItemList()->[PackingItem]{
        return itemList
    }
}
