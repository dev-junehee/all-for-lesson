//
//  JoinLabel.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

final class JoinLabel: UILabel {
    
    init(type: JoinCase) {
        super.init(frame: .zero)
        self.font = Resource.Font.viewTitle
        switch type {
        case .student:
            self.text = "수강생으로 가입해요"
        case .teacher:
            self.text = "선생님으로 가입해요"
        case .common:
            return
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
