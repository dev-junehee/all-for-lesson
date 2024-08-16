//
//  BasicLabel.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

final class CommonLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDefaultLabelStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setDefaultLabelStyle() {
        textColor = Resource.Color.fontBlack
    }
}
