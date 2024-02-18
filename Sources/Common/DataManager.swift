//
//  DataManager.swift
//  WithYou
//
//  Created by 김도경 on 2/8/24.
//  Copyright © 2024 withyou.org. All rights reserved.
//

import Foundation
import UIKit

struct DataManager {
    static let shared = DataManager()
    let defaults = UserDefaults.standard
    private init(){}
    
    //첫 앱 실행 확인
    func setIsFirstTime(){
        defaults.set(true, forKey: "isFirstTime")
    }
    
    func getIsFirstTime()->Bool{
        return defaults.bool(forKey: "isFirstTime")
    }
    
    func setIsLogin(){
        defaults.set(true, forKey: "Login")
    }
    
    func getIsLogin() -> Bool {
        return defaults.bool(forKey: "Login")
    }
    
    func getUserName()->String {
        return defaults.string(forKey: "UserName") ?? "Error"
    }
    func getUserImage()->Data{
        return defaults.data(forKey: "ProfilePicture")!
    }
    
    func saveImage(image : UIImage, key: String){
        let imageData = image.jpegData(compressionQuality: 0.5)
        defaults.set(imageData, forKey: key)
    }
    
    func saveText(text:String,key:String){
        //refresh token 앞 8자리로 저장
        defaults.set(text, forKey: key)
    }
}
