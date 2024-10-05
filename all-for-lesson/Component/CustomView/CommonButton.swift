//
//  BasicButton.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

final class CommonButton: UIButton {
    
    enum FontColor {
        case black
        case white
    }
    
    init(title: String, color: UIColor, fontColor: FontColor = .white, isEnabled: Bool = true) {
        super.init(frame: .zero)
        var config = UIButton.Configuration.filled()
        
        var title = AttributedString(title)
        title.font = Resource.Font.bold16
        config.attributedTitle = title
        
        config.baseBackgroundColor = color
        switch fontColor {
        case .black:
            config.baseForegroundColor = Resource.Color.fontBlack
        case .white:
            config.baseForegroundColor = Resource.Color.whiteSmoke
        }
        
        
        self.configuration = config
        self.isEnabled = isEnabled
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
