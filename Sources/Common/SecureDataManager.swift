//
//  SecureDataManager.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
enum TokenType : String{
    case accessToken
    case refreshToken
}

class SecureDataManager {
    let appName = "WithYou"
    
    
    
    func setData(_ token: String, label : TokenType)-> Bool{
        let saveQuery: NSDictionary = [kSecClass: kSecClassKey,
                                   kSecAttrLabel: label.rawValue,
                        kSecAttrApplicationLabel: appName,
                                   kSecValueData: token]
        let status = SecItemAdd(saveQuery, nil)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    func getData(label : TokenType) -> String {
        let searchQuery: NSDictionary = [kSecClass: kSecClassKey,
                                     kSecAttrLabel: label.rawValue,
                              kSecReturnAttributes: true,
                                    kSecReturnData: true]
        var result: CFTypeRef?
        let searchStatus = SecItemCopyMatching(searchQuery, &result)
        
        if searchStatus == errSecSuccess {
            guard let checkedItem = result,
                  let token = checkedItem[kSecValueData] as? Data else { return "Error"}
            return String(data: token, encoding: String.Encoding.utf8)!
        } else {
            return "불러오기 실패, status = \(searchStatus)"
        }
    }
}
