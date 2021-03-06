//
//  SceneDelegate.swift
//  usKet_Friend
//
//  Created by 이경후 on 2022/01/17.
//

import UIKit
import Firebase

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // 임시
        Helper.shared.registerUserData(userDataType: .isMatch, variable: MatchStatus.nothing.rawValue)
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene

        switch Helper.shared.userState() {
        // 온보딩
        case "onboard" :
            window?.rootViewController = OnboardViewController()
            window?.makeKeyAndVisible()
        // 닉네임
        case "nickName":
            window?.rootViewController = UINavigationController(rootViewController: NicknameViewController())
            window?.makeKeyAndVisible()
        // home
        case "home":
            UserAPI.getUser(idToken: Helper.shared.putIdToken()) { user, _ in

                guard let user = user else {
                    return
                }
                // 만약 기존의 FCM토큰과 다르다면 갱신해줘야해 홈으로 갈때마다!
                let parm = FCMtokenParm(FCMtoken: "").parameter
                if user.fcMtoken != parm.FCMtoken {
                    UserAPI.updateFCMToken(idToken: Helper.shared.putIdToken(), parameter: parm, onCompletion: { _ in })
                }
            }
            window?.rootViewController = HomeTabViewController()
            window?.makeKeyAndVisible()
        // 처음 + 오류
        default :
            window?.rootViewController = OnboardViewController()
            window?.makeKeyAndVisible()
        }

    }
    // MARK: - 여기서도 MatchStatus 값을 조정할 수 있을까
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
