//
//  UIViewController + Extension.swift
//  usKet_HobbyFriend
//
//  Created by 이경후 on 2022/01/20.
//

import Foundation
import UIKit
import Network

enum NextType {
    case push,present
}

extension UIViewController {
    
    func showToast(message : String, font : UIFont , width: CGFloat, height : CGFloat) {
        
        let toastLabel = UILabel(frame: CGRect(x: view.frame.size.width/2 - width/2, y: 50, width: width, height: height))
        
        //Configure
        toastLabel.backgroundColor = UIColor(resource: R.color.basicBlack)?.withAlphaComponent(0.5)
        toastLabel.textColor = UIColor(resource: R.color.basicWhite)
        toastLabel.numberOfLines = 0
        toastLabel.font = font
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        
        view.addSubview(toastLabel)
        //Animation
        UIView.animate(withDuration: 3.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        },
            completion: { Completed in
            toastLabel.removeFromSuperview()
        })
    }
    
    func transViewController(nextType : NextType, controller : UIViewController){

        switch nextType {
            
        case .push:
            let viewcontroller = controller
            controller.navigationItem.backBarButtonItem?.tintColor = .black
            self.navigationItem.backButtonTitle = ""
            self.navigationController?.pushViewController(viewcontroller, animated: true)
            
        case .present:
            let viewcontroller = controller
            self.present(viewcontroller, animated: true, completion: nil)
        }
    }
    
    func transViewWithAnimation(isNavigation : Bool,controller : UIViewController){
        guard let window = self.view.window else {
            return
        }
        UIView.transition(with: window, duration: 0.3, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            if isNavigation {
                self.view.window?.rootViewController = UINavigationController(rootViewController: controller)
            } else {
            self.view.window?.rootViewController = controller
            }
            self.view.window?.makeKeyAndVisible()
        }, completion: nil)
    }
    
    func monitorNetwork(){
        
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = {
            path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    return
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.showToast(message: "네트워크 연결 상태를 확인해주세요😭", font: UIFont.toBodyM16!, width: UIScreen.main.bounds.width * 0.8, height: 50)
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
}

