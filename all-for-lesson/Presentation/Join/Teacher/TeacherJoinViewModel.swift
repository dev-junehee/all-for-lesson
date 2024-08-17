//
//  TeacherJoinViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import RxCocoa
import RxSwift

final class TeacherJoinViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailText: ControlProperty<String?>
        let duplicationButtonTap: ControlEvent<Void>
        let passwordText: ControlProperty<String?>
        let nickText: ControlProperty<String?>
        let joinButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let emailValdation: BehaviorSubject<Bool>
        let emailDuplication: BehaviorSubject<(Int, String)>
        let validation: Observable<Bool>
        let joinSucceed: BehaviorSubject<Bool>
    }
    
    func transform(input: Input) -> Output {
        let emailValidation = BehaviorSubject<Bool>(value: false)
        let emailDuplication = BehaviorSubject<(Int, String)>(value: (0, ""))
        let joinSucceed = BehaviorSubject<Bool>(value: false)
        
        /// 이메일 유효성 검사 - 레이블
        input.emailText.orEmpty
            .map { emailText in
                return ValidationManager.shared.emailValidation(emailText)
            }
            .bind { result in
                print("이메일 유효성 검사 결과", result)
                emailValidation.onNext(result)
            }
            .disposed(by: disposeBag)
        
        /// 이메일 중복 확인 버튼 탭 - 중복 확인 API
        input.duplicationButtonTap
            .withLatestFrom(input.emailText.orEmpty)
            .distinctUntilChanged()
            .flatMap { emailText in
                return NetworkManager.shared.callRequest(api: .email(email: emailText), of: EmailResponse.self)
            }
            .bind(with: self, onNext: { owner, result in
                switch result {
                case .success(let response):
                    emailDuplication.onNext((200, response.message))
                case .failure(let error):
                    if let errorCode = error.asAFError?.responseCode {
                        switch errorCode {
                        case 400:
                            emailDuplication.onNext((400, "이메일을 입력해 주세요"))
                        case 409:
                            emailDuplication.onNext((409, "이미 사용 중인 이메일이에요"))
                        default:
                            emailDuplication.onNext((999, "알 수 없는 오류에요"))
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        /// 비밀번호 유효성 검사
        let passwordValidation = input.passwordText
            .orEmpty
            .map { $0.count >= 5 }
        
        let nickValidation = input.nickText
            .orEmpty
            .map { $0.count >= 3 }
        
        let validation = Observable
            .combineLatest(passwordValidation, nickValidation) { isPasswordValid, isNickValid in
            return isPasswordValid && isNickValid
        }
        
        let studentData = Observable
            .combineLatest(input.emailText.orEmpty,
                           input.passwordText.orEmpty,
                           input.nickText.orEmpty) { (email, password, nick) in
            return (email, password, nick)
        }
        
        /// 가입하기 버튼 탭
        input.joinButtonTap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .withLatestFrom(studentData)
            .flatMap { (email, password, nick) in
                print(email, password, nick)
                return NetworkManager.shared.callRequest(api: .join(email: email, password: password, nick: nick, phoneNum: "0"), of: JoinResponse.self)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let response):
                    print("회원가입 성공 ======")
                    print("이메일", response.email)
                    print("닉네임", response.nick)
                    print("userId", response.user_id)
                    
                    UserDefaultsManager.userType = "0"
                    UserDefaultsManager.userId = response.user_id
                    UserDefaultsManager.email = response.email
                    UserDefaultsManager.nick = response.nick
                    
                    joinSucceed.onNext(true)
                case .failure(let error):
                    print("회원가입 오류", error)
                }
            }
            .disposed(by: disposeBag)
            
        
        return Output(emailValdation: emailValidation,
                      emailDuplication: emailDuplication,
                      validation: validation,
                      joinSucceed: joinSucceed)
    }
    
}
