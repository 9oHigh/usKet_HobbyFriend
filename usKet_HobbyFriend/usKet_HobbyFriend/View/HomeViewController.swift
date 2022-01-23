//
//  HomeViewController.swift
//  usKet_HobbyFriend
//
//  Created by 이경후 on 2022/01/19.
//

import Foundation
import UIKit

class HomeViewController : UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = UIColor(resource: R.color.brandGreen)
        delegate = self
        setConfigure()
        setUI()
        setConstraints()
        bind()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let home = HomeTabViewController()
        let homeTabBarItem = UITabBarItem(title: "홈", image: UIImage(resource: R.image.tabHome),tag: 1)
        home.tabBarItem = homeTabBarItem
 
        let shop = ShopViewController()
        let shopTabBarItem = UITabBarItem(title: "새싹샵", image: UIImage(resource: R.image.tabGift),tag: 2)
        shop.tabBarItem = shopTabBarItem
        
        let friends = FriendsViewController()
        let friendsTabBarItem = UITabBarItem(title: "새싹친구", image: UIImage(resource: R.image.tabSeSAC),tag: 3)
        friends.tabBarItem = friendsTabBarItem
        
        let myinfo = MyInfoViewController()
        let myinfoTabBarItem = UITabBarItem(title: "내정보", image: UIImage(resource: R.image.tabPerson),tag: 4)
        myinfo.tabBarItem = myinfoTabBarItem
        
        self.viewControllers = [home, shop, friends,myinfo]
    }
    func setConfigure(){
        
        
    }
    
    func setUI(){
        
    }
    
    func setConstraints(){
        
    }
    
    func bind(){
        
    }
}
