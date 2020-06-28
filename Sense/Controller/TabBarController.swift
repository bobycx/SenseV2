//
//  TabBarController.swift
//  Sense
//
//  Created by Bob Yuan on 2019/12/4.
//  Copyright © 2019 Bob Yuan. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    var kBarHeight: CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.selectedIndex = 1
        tabBar.frame.size.height = 100
        tabBar.roundedTop(30)
        //let off = CGSize(width: CGFloat(10), height: CGFloat(10))
        tabBar.dropShadow(shadowColor: .black, opacity: 1, offset: .zero, radius: 10)

    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //tabBar.frame.size.height = CGFloat(kBarHeight)
        print(view.frame.height)
        tabBar.frame.origin.y = view.frame.height - kBarHeight
    }
    
    func configureTabBarItems() {
        let mainVC = ChooseLearningModeVC()
        let quizVC = QuizViewController()
        let listenVC = ListenViewController()
        
        let viewControllers : Array = [listenVC, mainVC, quizVC]
        
        let tabBarController = UITabBarController()
        
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedIndex = 1
        
        tabBarController.tabBar.frame.size.height = 100
        //tabBarController.tabBar.layer.position = CGPoint(x: 10,y: 818)
        
        let frame = tabBarController.tabBar.frame
        
        
        tabBarController.tabBar.roundedTop(30)
        tabBarController.tabBar.dropShadow()
        tabBarController.tabBar.barTintColor = .lightGray
        
        
        setTabBarItemImage(vc: mainVC, image: "icons8-mind_map")
        setTabBarItemImage(vc: quizVC, image: "icons8-artificial_intelligence")
        setTabBarItemImage(vc: listenVC, image: "icons8-audio_wave")
        
        for vc in viewControllers {
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
            vc.title = nil
        }
        
    }
    
    func setTabBarItemImage(vc: UIViewController, image: String) {
        let item = UITabBarItem()
        item.title = ""
        item.image = UIImage(named: image)
        
        vc.tabBarItem = item
    }
    
    /*
    override func viewWillLayoutSubviews() {
        let defaultTabBarHeight = { tabBar.frame.size.height }()
        super.viewWillLayoutSubviews()
        
        let newTabBarHeight = defaultTabBarHeight - 12.0
        
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        
        tabBar.frame = newFrame
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

