//
//  SceneDelegate.swift
//  test
//
//  Created by 김도경 on 1/8/24.
//

import GoogleSignIn
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //로그인화면 부터 실행하고 싶을 시
//        for key in UserDefaults.standard.dictionaryRepresentation().keys {
//            UserDefaults.standard.removeObject(forKey: key.description)
//        }
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: windowScene)
        print("SD: isFirstTime : \(DataManager.shared.getIsFirstTime())")
//        window?.rootViewController = TestTabbarViewController()
//       window?.makeKeyAndVisible()
//        if DataManager.shared.getIsLogin() {
//            //로그인 기록 있을 시
//            //Tabbar는 NavigationView로 할당하면 안됌
//            window?.rootViewController = TabBarViewController()
//            window?.makeKeyAndVisible()
//        } else {
//            //로그인 기록 없을 시
//            if !DataManager.shared.getIsFirstTime() {
//                //앱 처음 실행시
//                changeRootViewController(newVC: MyPageViewController())
//            } else {
//                changeRootViewController(newVC: LoginViewController())
//            }
//        }
        changeRootViewController(newVC: CreateLogViewController())
    }
    
    func changeRootViewController(newVC : UIViewController){
        let newVC = UINavigationController(rootViewController: newVC)
        window?.rootViewController = newVC
        window?.makeKeyAndVisible()
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else { return }
        let _ = GIDSignIn.sharedInstance.handle(url)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
      
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
       
    }


}

