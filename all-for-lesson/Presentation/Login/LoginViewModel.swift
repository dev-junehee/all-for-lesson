//
//  LoginViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LoginViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailText: ControlProperty<String?>
        let passwordText: ControlProperty<String?>
        let loginButtonTap: ControlEvent<Void>
        let joinButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let loginButtonEnabled: BehaviorSubject<Bool>
        let loginSucceed: BehaviorSubject<Bool>
        let joinButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        /// 이메일 비밀번호 유효성 검사
        let emailValidation = input.emailText.orEmpty.map { $0.contains("@") }
        let passwordValidation = input.passwordText.orEmpty.map { $0.count >= 5 }
        
        let validation = Observable.combineLatest(emailValidation, passwordValidation) {
            return $0 && $1
        }
        
        let loginButtonEnabled = BehaviorSubject(value: false)
        
        validation
            .bind(with: self) { owner, result in
                loginButtonEnabled.onNext(result)
            }
            .disposed(by: disposeBag)
        
        
        /// 로그인 API 연결
        let loginSucceed = BehaviorSubject(value: false)
        
        let accountData = Observable
            .combineLatest(input.emailText.orEmpty,
                           input.passwordText.orEmpty) { (email, password) in
                return (email, password)
            }
        
        input.loginButtonTap
            .withLatestFrom(accountData)
            .flatMap { (email, password) in
                return NetworkManager.shared.callRequest(api: .login(email: email, password: password), of: LoginResponse.self)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let response):
                    print("로그인 성공")
                    UserDefaultsManager.userId = response.user_id
                    UserDefaultsManager.email = response.email
                    UserDefaultsManager.nick = response.nick
                    UserDefaultsManager.profileImage = response.profileImage ?? ""
                    UserDefaultsManager.accessToken = response.accessToken
                    UserDefaultsManager.refreshToken = response.refreshToken
                    loginSucceed.onNext(true)
                case .failure(let error):
                    print("로그인 실패", error)
                    if let errorCode = error.asAFError?.responseCode {
                        switch errorCode {
                        case 400:
                            // 필수값을 채워주세요 (이메일 or 비밀번호 누락)
                            return
                        case 401:
                            // 계정을 확인해 주세요 (미가입 or 비밀번호 불일치)
                            return
                        default:
                            // 알 수 없는 오류
                            return
                        }
                    }
                }
            }
            .disposed(by: disposeBag)
        
        return Output(loginButtonEnabled: loginButtonEnabled,
                      loginSucceed: loginSucceed,
                      joinButtonTap: input.joinButtonTap)
    }
    
}
