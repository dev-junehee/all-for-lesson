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
    
    func setTabBar(with viewControllers: [UIViewController]) {
        self.setViewControllers(viewControllers, animated: true)
    }
    
    func createTabBarItem(title: String, image: UIImage?, viewController: UIViewController) -> UINavigationController {
        
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
