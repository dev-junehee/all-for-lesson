//
//  MyPageMenuButton.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit
import SnapKit

final class MyPageMenuButton: UIButton {
    
    init(_ titleText: String, image: UIImage) {
        super.init(frame: .zero)
       
        /// configuration 지정 - 배경색, 폰트색
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Resource.Color.paleGray
        config.baseForegroundColor = Resource.Color.fontBlack
        config.cornerStyle = .small
        
        /// 버튼 타이틀
        var title = AttributedString(titleText)
        title.font = Resource.Font.bold14
        config.attributedTitle = title
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: -10, bottom: 0, trailing: 0)
        
        /// 버튼 이미지
        config.image = image
        config.imagePlacement = .leading
        config.imagePadding = 6
        
        self.configuration = config
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
