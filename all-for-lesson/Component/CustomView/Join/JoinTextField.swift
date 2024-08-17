//
//  JoinTextField.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import TextFieldEffects

final class JoinTextField: HoshiTextField {
    
    init(type: JoinCase, placeholder: String) {
        super.init(frame: .zero)
        
        switch type {
        case .student:
            self.borderActiveColor = Resource.Color.yellow
            self.tintColor = Resource.Color.yellow
        case .teacher:
            self.borderActiveColor = Resource.Color.skyblue
            self.tintColor = Resource.Color.skyblue
        case .common:
            self.borderActiveColor = Resource.Color.purple
            self.tintColor = Resource.Color.purple
        }
        
        self.placeholder = placeholder
        self.placeholderColor = Resource.Color.darkGray
        self.borderInactiveColor = Resource.Color.darkGray
        self.returnKeyType = .done
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
