//
//  UIViewController+.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import UIKit

extension UIViewController {
    
    /// Image BarButton 설정 함수
    func setImgBarButton(image: UIImage, target: Any?, action: Selector?, type: BarButtonCase) {
        let barButton = UIBarButtonItem(image: image, style: .plain, target: target, action: action)
    
        barButton.tintColor = Resource.Color.purple
    
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    /// 뒤로가기 BarButton 설정 함수
    func setBackBarButton() {
        let backImage = Resource.SystemImage.leftArrow
        let barButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
        barButton.tintColor = Resource.Color.purple
        navigationItem.leftBarButtonItem = barButton
    }
    
    /// RootViewController - Onboarding으로 변경
    func changeRootViewControllerToOnboarding() {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDeleagate = windowScene?.delegate as? SceneDelegate
        
        let onboardingVC = UINavigationController(rootViewController: OnboardingViewController())
        sceneDeleagate?.window?.rootViewController = onboardingVC
        sceneDeleagate?.window?.makeKeyAndVisible()
    }
    
    /// RootViewController - Onboarding으로 변경
    
    
    
    
    /// 뒤로가기
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func hideTabBar() {
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func showTabBar() {
        self.tabBarController?.tabBar.isHidden = false
    }
    
}
