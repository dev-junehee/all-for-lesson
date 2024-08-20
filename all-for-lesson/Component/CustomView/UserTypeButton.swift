//
//  UserTypeButton.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit
import SnapKit

final class UserTypeButton: UIButton {
    
    init(type: JoinCase) {
        super.init(frame: .zero)
        
        var backgroundColor: UIColor
        var foregroundColor: UIColor
        var titleText: String
        
        switch type {
        case .student, .common:
            backgroundColor = Resource.Color.ivory
            foregroundColor = Resource.Color.lightGray
            titleText = "수강생"
        case .teacher:
            backgroundColor = Resource.Color.purple
            foregroundColor = Resource.Color.white
            titleText = "선생님"
        }
        
        /// configuration 지정 - 배경색, 폰트색
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = backgroundColor
        config.baseForegroundColor = foregroundColor
        config.cornerStyle = .capsule
        
        /// 버튼 타이틀
        var title = AttributedString(titleText)
        title.font = Resource.Font.bold14
        config.attributedTitle = title
        
        self.configuration = config
        
        self.snp.makeConstraints {
            $0.width.equalTo(65)
            $0.height.equalTo(25)
        }
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
