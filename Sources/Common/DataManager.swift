//
//  DataManager.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation

struct DataManager {
    static let shared = DataManager()
    let defaults = UserDefaults.standard
    private init(){
    }
    
    //첫 앱 실행 확인
    func setIsFirstTime(){
        defaults.set(true, forKey: "isFirstTime")
    }
    func getIsFirstTime()->Bool{
        return defaults.bool(forKey: "isFirstTime")
    }
  
}
