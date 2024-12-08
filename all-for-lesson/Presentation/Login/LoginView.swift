//
//  LoginView.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import SnapKit
import Then

final class LoginView: BaseView {
    
    private let loginLabel = CommonLabel().then {
        $0.text = Constant.Login.login
        $0.font = Resource.Font.viewTitle
    }
    
    let emailField = JoinTextField(type: .common, placeholder: Constant.Join.email)
    let passwordField = JoinTextField(type: .common, placeholder: Constant.Join.password, isSecure: true)
    let loginButton = CommonButton(title: Constant.Login.login, color: Resource.Color.purple, isEnabled: false)
    
    private let joinLabel = CommonLabel().then {
        $0.text = Constant.Login.noAccount
        $0.font = Resource.Font.regular14
    }
    
    let joinButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Resource.Color.fontBlack
        var title = AttributedString(Constant.Join.signUp)
        title.font = Resource.Font.bold14
        config.attributedTitle = title
        $0.configuration = config
    }
    
    override func setHierarchyLayout() {
        [loginLabel, emailField, passwordField, loginButton, joinLabel, joinButton].forEach { self.addSubview($0) }
        
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
        
        joinLabel.snp.makeConstraints {
            $0.top.equalTo(loginButton.snp.bottom).offset(40)
            $0.centerX.equalTo(safeArea)
            $0.height.equalTo(30)
        }
        
        joinButton.snp.makeConstraints {
            $0.top.equalTo(joinLabel.snp.bottom)
            $0.centerX.equalTo(safeArea)
            $0.height.equalTo(20)
        }
    }
    
}
