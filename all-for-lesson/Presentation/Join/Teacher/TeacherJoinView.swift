//
//  TeacherJoinView.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import SnapKit
import Then

final class TeacherJoinView: BaseView {
    
    private let typeLabel = JoinLabel(type: .teacher)
    
    let emailField = JoinTextField(type: .teacher, placeholder: "이메일을 입력해 주세요")
    let validationResultLabel = CommonLabel().then {
        $0.font = Resource.Font.regular14
    }
    let duplicationButton = UIButton().then {
        $0.setTitle("중복 확인", for: .normal)
        $0.titleLabel?.font = Resource.Font.bold14
        $0.backgroundColor = Resource.Color.lightGray
        $0.isEnabled = false
        $0.layer.cornerRadius = 12
    }
    let passwordField = JoinTextField(type: .teacher, placeholder: "비밀번호를 입력해 주세요", isSecure: true)
    let nickField = JoinTextField(type: .teacher, placeholder: "이름을 입력해 주세요")
    let joinButton = CommonButton(title: "가입하기", color: Resource.Color.skyblue, isEnabled: false)

    override func setHierarchyLayout() {
        [typeLabel, emailField, validationResultLabel, duplicationButton, passwordField, nickField, joinButton].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(100)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(typeLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(60)
        }
        
        validationResultLabel.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(8)
            $0.leading.equalTo(safeArea).offset(16)
            $0.trailing.equalTo(duplicationButton.snp.leading)
            $0.height.equalTo(30)
        }
        
        duplicationButton.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(8)
            $0.leading.equalTo(validationResultLabel.snp.trailing)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(validationResultLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(60)
        }
        
        nickField.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(60)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(nickField.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
        }
        
    }
    
}
