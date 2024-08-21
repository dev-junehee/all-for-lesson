//
//  LoginViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginViewController: BaseViewController {
    
    var loginViewCase: LoginViewCase = .no
    
    private let loginView = LoginView()
    private let viewModel = LoginViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        switch loginViewCase {
        case .first:
            return
        case .no:
            setBackBarButton()
        }
        
    }
    
    private func bind() {
        let input = LoginViewModel.Input(emailText: loginView.emailField.rx.text,
                                         passwordText: loginView.passwordField.rx.text,
                                         loginButtonTap: loginView.loginButton.rx.tap,
                                         joinButtonTap: loginView.joinButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        /// 이메일/비밀번호 유효성 검사 - 로그인 버튼 활성화
        output.loginButtonEnabled
            .bind(with: self, onNext: { owner, result in
                owner.loginView.loginButton.isEnabled = result
            })
            .disposed(by: disposeBag)
        
        /// 로그인 성공 - 홈 화면 전환
        output.loginSucceed
            .bind(with: self) { owner, result in
                if result {
                    NavigationManager.shared.changeRootViewControllerToHome()
                }
            }
            .disposed(by: disposeBag)
        
        /// 회원가입 버튼 탭 - 온보딩 화면으로 전환
        output.joinButtonTap
            .bind(with: self) { owner, _ in
                NavigationManager.shared.changeRootViewControllerToOnboarding()
            }
            .disposed(by: disposeBag)
    }
    
}
