//
//  BaseViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViewController()
        setHierarchyLayout()
    }
    
    func setViewController() { }
    
    func setHierarchyLayout() { }
    
}
