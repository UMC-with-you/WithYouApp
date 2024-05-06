//
//  PackingItemRouter.swift
//  WithYou
//
//  Created by 김도경 on 2/6/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Alamofire
import Foundation

enum PackingItemRouter {
    case getItemList(travelId : Int)
    case addItem(travelId : Int, itemName : String)
    case deleteItem(packingItemId : Int)
    case checkItem(packingItemId : Int)
    case setItemMember(packingItemId : Int, itemMemberId : Int)
}

extension PackingItemRouter : BaseRouter {
    var baseURL: String {
        Constants.baseURL
    }
    
    var method: HTTPMethod {
        switch self{
        case .getItemList : return .get
        case .addItem : return .post
        case .deleteItem : return .delete
        case .checkItem, .setItemMember : return .patch
        }
    }
    
    var path: String {
        switch self{
        case .getItemList(let id), .addItem(let id,_) :
            return "/travels/\(id)/packing_items"
        case .deleteItem(let itemId), .checkItem(let itemId):
            return "/packing_items/\(itemId)"
        case .setItemMember(let itemId , _):
            return "/packing_items/\(itemId)/packer_choice"
        }
    }
    
    var parameter: RequestParams {
        switch self{
        case .getItemList, .deleteItem, .checkItem :
            return .none
        case .addItem(_, let name) :
            return .body(["itemName" : name])
        case .setItemMember(_, let memberId):
            return .query(["packer_id" : memberId])
        }
    }
    
    var header: HeaderType {
        switch self{
        case .addItem:
            return .basicHeader
        default :
            return .noHeader
        }
    }
    
    
}
