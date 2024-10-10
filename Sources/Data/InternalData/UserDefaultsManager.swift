//
//  DataManager.swift
//  Data
//
//  Created by bryan on 2024/07/16.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

@propertyWrapper
struct MyDefaults<T> {
    let key: String
    let defaultValue: T
    
    var wrappedValue: T {
        get {
            UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

public enum UserDefaultsManager {
    enum Key: String {
        case isFirstTime, isLoggined
    }
    
    @MyDefaults(key: Key.isFirstTime.rawValue, defaultValue: false)
    public static var isFirstTime

    @MyDefaults(key: Key.isLoggined.rawValue, defaultValue: false)
    public static var isLoggined
}

