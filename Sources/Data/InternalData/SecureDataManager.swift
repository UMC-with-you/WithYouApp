//
//  SecureDataManager.swift
//  Data
//
//  Created by 김도경 on 5/14/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import Security
import RxSwift

enum TokenType : String{
    case accessToken
    case refreshToken
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case duplicatedItem
    case unhandledError(status: OSStatus)
}

class SecureDataManager {
    static let shared = SecureDataManager()
    
    let serviceName = "WithYou"
    let appName = "WithYou"
    
    private init(){}
    
    func saveToken(authToken: AuthToken) -> Single<Void> {
        return Single<Void>.create { single in
            
            let accessStatus = self.setData(authToken.accessToken, label: .accessToken)
            
            let refreshStatus = self.setData(authToken.refreshToken, label: .refreshToken)
            
            if accessStatus == errSecSuccess && refreshStatus == errSecSuccess {
                single(.success(()))
            } else if accessStatus == errSecDuplicateItem || refreshStatus == errSecDuplicateItem {
                single(.failure(KeychainError.duplicatedItem))
            } else {
                single(.failure(KeychainError.unhandledError(status: accessStatus)))
            }
            
            return Disposables.create {}
        }
    }
    
    internal func setData(_ token: String, label : TokenType)-> OSStatus {
        let keychainItem = [
                    kSecClass: kSecClassGenericPassword,
                    kSecAttrAccount: label.rawValue,
                    kSecAttrService: serviceName,
                    kSecValueData: token.data(using: .utf8, allowLossyConversion: false)!
                ] as NSDictionary
        
        //Test 우선 아이템 지우고 시작
        SecItemDelete(keychainItem)
        
        let status = SecItemAdd(keychainItem as CFDictionary, nil)
        return status
    }
    
    internal func getData(label : TokenType) -> String {
        let searchQuery: NSDictionary = [kSecClass: kSecClassGenericPassword,
                                     kSecAttrAccount: label.rawValue,
                                  kSecAttrService : serviceName,
                                    kSecReturnData: kCFBooleanTrue!]
        var result: AnyObject?
        let searchStatus = SecItemCopyMatching(searchQuery, &result)
        
        if searchStatus == errSecSuccess {
            guard let token = result as? Data else { return "Error"}
            print("SecureDataManager: 불러오기 성공")
            return String(data: token, encoding: String.Encoding.utf8)!
        } else {
            return "SecureDataManager: 불러오기 실패, status = \(searchStatus)"
        }
    }
}
