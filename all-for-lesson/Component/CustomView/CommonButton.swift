//
//  BasicButton.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

final class CommonButton: UIButton {
    
    init(title: String, color: UIColor, fontColor: Bool = true, isEnabled: Bool = true) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        
        var title = AttributedString(title)
        title.font = Resource.Font.bold16
        config.attributedTitle = title
        
        config.baseBackgroundColor = color
        config.baseForegroundColor = fontColor ? Resource.Color.whiteSmoke : Resource.Color.fontBlack
        
        self.configuration = config
        self.isEnabled = isEnabled
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
