//
//  AppDelegate.swift
//  test
//
//  Created by 김도경 on 1/8/24.
//

import UIKit
import Photos

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // 앱이 시작될 때 Photo Library 권한 요청
        PHPhotoLibrary.requestAuthorization { status in
            switch status {
            case .authorized:
                // 권한 획득 성공
                print("Photo Library 권한이 허용되었습니다.")
            case .denied, .restricted:
                // 권한 거부 또는 제한됨
                print("Photo Library 권한이 거부되었거나 제한되었습니다.")
            case .notDetermined:
                // 권한이 아직 결정되지 않음
                print("Photo Library 권한이 아직 결정되지 않았습니다.")
            @unknown default:
                break
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    


}

