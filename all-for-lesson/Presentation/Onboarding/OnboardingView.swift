//
//  OnboardingView.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import SnapKit
import Then

final class OnboardingView: BaseView {
    
    private let welcomeMessageLabel = UILabel().then {
        $0.text = Constant.Onboarding.welcome
        $0.font = Resource.Font.viewTitle
        $0.numberOfLines = 0
    }
    
    let studentButton = OnboardingTypeButton(title: Constant.Onboarding.student,
                                             subTitle: Constant.Onboarding.studentDescription,
                                             image: .teacher,
                                             color: Resource.Color.yellow)
    
    let teacherButton = OnboardingTypeButton(title: Constant.Onboarding.teacher,
                                             subTitle: Constant.Onboarding.teacherDescription,
                                             image: .teacher,
                                             color: Resource.Color.skyblue)
    
    private let haveAccountLabel = CommonLabel().then {
        $0.text = Constant.Onboarding.account
        $0.font = Resource.Font.regular14
    }
    
    let loginButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Resource.Color.fontBlack
        var title = AttributedString(Constant.Onboarding.login)
        title.font = Resource.Font.bold14
        config.attributedTitle = title
        $0.configuration = config
    }
    
    override func setHierarchyLayout() {
        [welcomeMessageLabel, studentButton, teacherButton, haveAccountLabel, loginButton].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        welcomeMessageLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(100)
        }
        
        studentButton.snp.makeConstraints {
            $0.top.equalTo(welcomeMessageLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(160)
        }
        
        teacherButton.snp.makeConstraints {
            $0.top.equalTo(studentButton.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(160)
        }
        
        haveAccountLabel.snp.makeConstraints {
            $0.top.equalTo(teacherButton.snp.bottom).offset(40)
            $0.centerX.equalTo(safeArea)
            $0.height.equalTo(30)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(haveAccountLabel.snp.bottom)
            $0.centerX.equalTo(safeArea)
            $0.height.equalTo(20)
        }
    }
    
}
