//
//  SceneDelegate.swift
//  usKet_Friend
//
//  Created by 이경후 on 2022/01/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        lazy var toSignUp = LoginSingleTon()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        
        switch toSignUp.userState() {
        //온보딩
        case "onboard" :
            print(toSignUp.userState())
            window?.rootViewController = OnboardViewController()
            window?.makeKeyAndVisible()
        //닉네임
        case "nickName":
            print(toSignUp.userState())
            window?.rootViewController = UINavigationController(rootViewController:  NicknameViewController())
            window?.makeKeyAndVisible()
        //home
        case "home":
            print(toSignUp.userState())
            window?.rootViewController = HomeViewController()
            window?.makeKeyAndVisible()
        //처음 + 오류
        default :
            print(toSignUp.userState())
            window?.rootViewController = OnboardViewController()
            window?.makeKeyAndVisible()
        }

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

