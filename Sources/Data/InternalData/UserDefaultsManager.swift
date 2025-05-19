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
            if T.self == UIImage.self {
                if let data = UserDefaults.standard.data(forKey: key),
                   let image = UIImage(data: data) {
                    return image as! T
                }
                return defaultValue
            }

            return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue
        }
        set {
            if let image = newValue as? UIImage,
               let data = image.pngData() {
                UserDefaults.standard.set(data, forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
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

