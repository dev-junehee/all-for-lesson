//
//  LoginView.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import SnapKit

final class LoginView: BaseView {
    
    private let loginLabel = CommonLabel().then {
        $0.text = "로그인"
        $0.font = Resource.Font.viewTitle
    }
    
    let emailField = SignUpTextField(type: .student, placeholder: "이메일을 입력해 주세요")
    let passwordField = SignUpTextField(type: .student, placeholder: "비밀번호를 입력해 주세요")
    let loginButton = CommonButton(title: "로그인", color: Resource.Color.yellow, isEnabled: true)
    
    override func setHierarchyLayout() {
        [loginLabel, emailField, passwordField, loginButton].forEach {
            self.addSubview($0)
        }
        
        let safeArea = self.safeAreaLayoutGuide
        
        loginLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(100)
        }
        
        emailField.snp.makeConstraints {
            $0.top.equalTo(loginLabel.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(60)
        }
        
        passwordField.snp.makeConstraints {
            $0.top.equalTo(emailField.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(60)
        }
        
        loginButton.snp.makeConstraints {
            $0.top.equalTo(passwordField.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
        }
    }
    
    
    
    
}
