//
//  CustomTabBarController.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import UIKit

final class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarUI()
    }
    
    func setDefaultTabBar() {
        let home = createTabBarItem(title: Constant.Tab.home, image: Resource.Image.home, viewController: HomeViewController())
        let hashtag = createTabBarItem(title: Constant.Tab.hashtag, image: Resource.Image.hashtag, viewController: HashTagViewController())
        let community = createTabBarItem(title: Constant.Tab.community, image: Resource.Image.board, viewController: CommunityViewController())
        let mypage = createTabBarItem(title: Constant.Tab.mypage, image: Resource.Image.person, viewController: MyPageViewController())
        
        let viewControllers = [home, hashtag, community, mypage]
        self.setViewControllers(viewControllers, animated: true)
    }
    
    private func createTabBarItem(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
    private func setTabBarUI() {
        tabBar.backgroundColor = Resource.Color.paleGray
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = Resource.Color.lightGray.cgColor
        tabBar.tintColor = Resource.Color.purple
    }
    
}
