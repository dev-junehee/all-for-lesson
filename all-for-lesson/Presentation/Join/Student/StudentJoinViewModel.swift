//
//  StudentJoinViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import RxCocoa
import RxSwift

final class StudentJoinViewModel: BaseViewModel {
    
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
        let emailDuplication: BehaviorSubject<String>
        let validation: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        let emailValidation = BehaviorSubject<Bool>(value: false)
        let emailDuplication = BehaviorSubject<String>(value: "")
        
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
                print("보내기 전 이메일 확인", emailText)
                return NetworkManager.shared.callRequest(api: .email(email: emailText), of: EmailResponse.self)
            }
            .bind(with: self, onNext: { owner, result in
                switch result {
                case .success(let response):
                    emailDuplication.onNext(response.message)
                case .failure(let error):
                    print("이메일 중복 확인 오류", error)
                    emailDuplication.onNext("오류가 발생했어요")
                }
            })
            .disposed(by: disposeBag)
        
        /// 비밀번호 유효성 검사
        let passwordValidation = input.passwordText
            .orEmpty
            .map { $0.count >= 8}
        
        let nickValidation = input.nickText
            .orEmpty
            .map { $0.count >= 3 }
        
        let validation = Observable.combineLatest(passwordValidation, nickValidation) { isPasswordValid, isNickValid in
            return isPasswordValid && isNickValid
        }
        
        return Output(emailValdation: emailValidation,
                      emailDuplication: emailDuplication,
                      validation: validation)
    }
    
}
