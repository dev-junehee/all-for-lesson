//
//  NavigationManager.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit

final class NavigationManager {
    
    static let shared = NavigationManager()
    private init() { }
    
    /// 온보딩 화면으로 전환
    func changeRootViewControllerToOnboarding() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let loginVC = UINavigationController(rootViewController: OnboardingViewController())
        sceneDeleagate?.window?.rootViewController = loginVC
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    /// 로그인 화면으로 전환
    func changeRootViewControllerToLogin() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let loginVC = LoginViewController()
        loginVC.loginViewCase = .first
        sceneDeleagate?.window?.rootViewController = UINavigationController(rootViewController: loginVC)
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    /// 앱 기본 화면으로 전환 (탭)
    func changeRootViewControllerToHome() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let tabBarController = CustomTabBarController()
        tabBarController.setDefaultTabBar()
        sceneDeleagate?.window?.rootViewController = tabBarController
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
}
