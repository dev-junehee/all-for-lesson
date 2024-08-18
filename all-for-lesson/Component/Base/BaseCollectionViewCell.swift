//
//  BaseCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setHierarchyLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setHierarchyLayout() { }
    
}
