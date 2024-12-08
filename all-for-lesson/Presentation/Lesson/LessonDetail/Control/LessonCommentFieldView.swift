//
//  LessonCommentFieldView.swift
//  all-for-lesson
//
//  Created by junehee on 8/27/24.
//

import UIKit
import SnapKit
import Then

/**
 레슨 상세 화면 - 레슨 후기 - 댓글 작성 부분
 */
final class LessonCommentFieldView: BaseView {
    
    let commentField = UITextField().then {
        $0.placeholder = Constant.Lesson.lessonComment
        $0.font = Resource.Font.regular14
        $0.tintColor = Resource.Color.yellow
    }
   
    let commentButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Resource.Color.yellow
        config.baseForegroundColor = Resource.Color.fontBlack
        
        var title = AttributedString(Constant.Lesson.submit)
        title.font = Resource.Font.bold14
        config.attributedTitle = title
        $0.configuration = config
    }
    
    override func setHierarchyLayout() {
        [commentField, commentButton].forEach { self.addSubview($0) }
        
        commentField.snp.makeConstraints {
            $0.centerY.equalTo(self).offset(-8)
            $0.leading.equalTo(self).inset(24)
            $0.trailing.equalTo(commentButton.snp.leading)
            $0.height.equalTo(40)
        }
        
        commentButton.snp.makeConstraints {
            $0.centerY.equalTo(self).offset(-8)
            $0.trailing.equalTo(self).inset(24)
            $0.width.equalTo(60)
            $0.height.equalTo(40)
        }
    }
    
    
}
