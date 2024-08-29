//
//  UIViewController+.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import UIKit

extension UIViewController {
    
    /// Image BarButton 설정 함수
    func setImgBarButton(image: UIImage, color: UIColor? = Resource.Color.purple, action: Selector?, type: BarButtonCase) {
        let barButton = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    
        barButton.tintColor = color
    
        switch type {
        case .left:
            navigationItem.leftBarButtonItem = barButton
        case .right:
            navigationItem.rightBarButtonItem = barButton
        }
    }
    
    /// 뒤로가기 BarButton 설정 함수
    func setBackBarButton(_ color: UIColor = Resource.Color.purple) {
        let backImage = Resource.Image.leftArrow
        let barButton = UIBarButtonItem(image: backImage, style: .plain, target: self, action: #selector(popViewController))
        barButton.tintColor = color
        navigationItem.leftBarButtonItem = barButton
    }
    
    /// 뒤로가기
    @objc func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    
    func toggleTabBar(isShow: Bool = true) {
        self.tabBarController?.tabBar.isHidden = isShow ? false : true
    }
    
}
