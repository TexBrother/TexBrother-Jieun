//
//  TabBarController.swift
//  TextureProject
//
//  Created by 황지은 on 2021/09/01.
//

import UIKit
import AsyncDisplayKit

class TabBarController: ASTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
    }
    
    // MARK: - 탭바 만드는 함수
    
    func setTabBar() {
        
        self.tabBar.tintColor = UIColor.black
        
        let vc1 = KakaoFriendVC()
        vc1.tabBarItem.image = UIImage(named: "friendTabIcon")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        vc1.tabBarItem.selectedImage = UIImage(named: "friendTabIconSelected")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        let vc2 = ViewController()
        vc2.tabBarItem.image = UIImage(named: "detailTabIcon")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        vc2.tabBarItem.selectedImage = UIImage(named: "detailTabIconSelected")?.withAlignmentRectInsets(UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0))
        
        let tabs =  [vc1, vc2]
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.barTintColor = .white
        self.setViewControllers(tabs, animated: false)
    }
}
