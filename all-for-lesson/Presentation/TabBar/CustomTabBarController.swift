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
        let home = createTabBarItem(title: "홈", image: Resource.SystemImage.home, viewController: HomeViewController())
        let lesson = createTabBarItem(title: "레슨찾기", image: Resource.SystemImage.piano, viewController: LessonViewController())
        let search = createTabBarItem(title: "검색", image: Resource.SystemImage.search, viewController: SearchViewController())
        let community = createTabBarItem(title: "커뮤니티", image: Resource.SystemImage.board, viewController: CommunityViewController())
        let mypage = createTabBarItem(title: "마이페이지", image: Resource.SystemImage.person, viewController: MyPageViewController())
        
        let viewControllers = [home, lesson, search, community, mypage]
        self.setViewControllers(viewControllers, animated: true)
    }
    
    func setCustomTabBar(with viewControllers: [UIViewController]) {
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
