//
//  PackingItem.swift
//  WithYou
//
//  Created by 김도경 on 1/26/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import RxDataSources

struct PackingItem : Equatable, Identifiable {
    var id : Int
    var logId : Int
    var itemName : String
}

// RxDataSources 용
struct SectionOfPackingItem {
    var header : String
    var items : [Item]
}

extension SectionOfPackingItem : SectionModelType {
    typealias Item = PackingItem
    
    init(original : SectionOfPackingItem, items : [PackingItem]){
        self = original
        self.items = items
    }
}
