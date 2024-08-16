//
//  OnboardingTypeButton.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

final class OnboardingTypeButton: UIButton {
        
    init(title: String, subTitle: String, image: UIImage? = nil, color: UIColor) {
        super.init(frame: .zero)
        
        /// configuration 지정 - 배경색, 폰트색
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = color
        config.baseForegroundColor = Resource.Color.fontBlack
        
        /// 버튼 타이틀
        var title = AttributedString(title)
        title.font = Resource.Font.bold20
        config.attributedTitle = title
        
        /// 버튼 서브타이틀
        var subTitle = AttributedString(subTitle)
        subTitle.font = Resource.Font.regular14
        config.attributedSubtitle = subTitle
        
        config.titlePadding = 6
        
        /// 버튼 이미지
        // config.image = image
        // config.imagePlacement = .leading
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12)
        config.preferredSymbolConfigurationForImage = imageConfig
        
        self.configuration = config
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
