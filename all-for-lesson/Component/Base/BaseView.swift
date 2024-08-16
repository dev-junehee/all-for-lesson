//
//  BaseView.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

class BaseView: UIView, Base {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViewController()
        setHierarchyLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewController() { }
    
    func setHierarchyLayout() { }
    
}
