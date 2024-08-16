//
//  LoginViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

final class LoginViewController: BaseViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
