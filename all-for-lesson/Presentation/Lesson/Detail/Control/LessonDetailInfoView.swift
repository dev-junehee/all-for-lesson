//
//  LessonDetailInfoView.swift
//  all-for-lesson
//
//  Created by junehee on 8/27/24.
//

import UIKit
import SnapKit
import Then

/**
 레슨 상세 화면 - Segmented Control - 레슨 상세 정보
 */
final class LessonDetailInfoView: BaseView {
    
    /// 선생님 정보 (프로필 이미지 + 이름 + 전공 + 위치)
    let teacherProfileImage = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = .person
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 40
        $0.backgroundColor = Resource.Color.lightGray
        $0.contentMode = .scaleAspectFit
        $0.configuration = config
    }
    
    let teacherName = UILabel().then {
        $0.font = Resource.Font.bold18
    }
    
    let teacherMajor = UILabel().then {
        $0.font = Resource.Font.regular14
    }
    
    let teacherLocation = UILabel().then {
        $0.font = Resource.Font.regular14
    }
    
    /// 레슨 상세
    let lessonContent = UITextView().then {
        $0.font = Resource.Font.regular14
        $0.isUserInteractionEnabled = false
    }
    
    override func setHierarchyLayout() {
        [teacherProfileImage, teacherName, teacherMajor, teacherLocation, lessonContent].forEach { self.addSubview($0) }
        
        teacherProfileImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(80)
        }
    
        teacherName.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(teacherProfileImage.snp.trailing).offset(16)
            $0.height.equalTo(35)
        }
        
        teacherMajor.snp.makeConstraints {
            $0.top.equalTo(teacherName.snp.bottom)
            $0.leading.equalTo(teacherProfileImage.snp.trailing).offset(16)
            $0.height.equalTo(20)
        }
        
        teacherLocation.snp.makeConstraints {
            $0.top.equalTo(teacherMajor.snp.bottom)
            $0.leading.equalTo(teacherProfileImage.snp.trailing).offset(16)
            $0.height.equalTo(20)
        }
        
        /// 레슨 소개
        lessonContent.snp.makeConstraints {
            $0.top.equalTo(teacherLocation.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(self)
            $0.height.equalTo(400)
        }
        
    }
    
}
