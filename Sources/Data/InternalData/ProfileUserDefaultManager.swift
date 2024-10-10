//
//  ProfileUserDefaultManager.swift
//  WithYou
//
//  Created by bryan on 9/26/24.
//

import Foundation


public enum ProfileUserDefaultManager {
    enum Key: String {
        case profileImage, userName
    }
    
    @MyDefaults(key: Key.profileImage.rawValue, defaultValue: Data())
    public static var profileImage

    @MyDefaults(key: Key.userName.rawValue, defaultValue: "")
    public static var userName
}
