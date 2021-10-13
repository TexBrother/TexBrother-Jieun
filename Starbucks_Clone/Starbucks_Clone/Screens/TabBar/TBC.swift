//
//  TBC.swift
//  Starbucks_Clone
//
//  Created by 황지은 on 2021/09/22.
//

import AsyncDisplayKit
import UIKit

class TBC: ASTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBar()
        self.view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 812)
    }
    
    // MARK: - 탭바 만드는 함수
    func setTabBar() {
        
        // 탭바 스타일 설정
        tabBar.tintColor = .seaweedGreen
        tabBar.frame.size.height = 65
        tabBar.layer.shadowOpacity = 0
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        tabBar.barTintColor = .white
        
        // HomeVC
        let vc1 = HomeVC()
        vc1.tabBarItem  = UITabBarItem(title: nil, image: UIImage(named: "HomeUnSelected"), selectedImage: UIImage(named: "HomeSelected"))
        vc1.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)
        
        // PayVC
        let vc2 = ASNavigationController(rootViewController: CardDetailVC())
        vc2.tabBarItem  = UITabBarItem(title: nil, image: UIImage(named: "PayUnSelected"), selectedImage: UIImage(named: "PaySelected"))
        vc2.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)
        
        // OrderVC
        let vc3 = OrderVC()
        vc3.tabBarItem  = UITabBarItem(title: nil, image: UIImage(named: "OrderUnSelected"), selectedImage: UIImage(named: "OrderSelected"))
        vc3.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)
        
        // GiftVC
        let vc4 = GiftVC()
        vc4.tabBarItem  = UITabBarItem(title: nil, image: UIImage(named: "GiftUnSelected"), selectedImage: UIImage(named: "GiftSelected"))
        vc4.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)

        // OtherVC
        let vc5 = OtherVC()
        vc5.tabBarItem  = UITabBarItem(title: nil, image: UIImage(named: "OtherUnSelected"), selectedImage: UIImage(named: "OtherSelected"))
        vc5.tabBarItem.imageInsets = UIEdgeInsets(top: 9, left: 0, bottom: -8.5, right: 0)

        
        // 탭 구성
        let tabs =  [vc1, vc2, vc3, vc4, vc5]
    
        // VC에 루트로 설정
        self.setViewControllers(tabs, animated: false)
    }
}
