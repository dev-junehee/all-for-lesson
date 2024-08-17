//
//  HomeViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import Foundation

final class HomeViewController: BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeViewController")
        
        
        print(UserDefaultsManager.email)
        print(UserDefaultsManager.nick)
        print(UserDefaultsManager.userId)
        print(UserDefaultsManager.userType)
        print(UserDefaultsManager.accessToken)
        print(UserDefaultsManager.refreshToken)
    }
    
}
