//
//  StudentSignUpViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import RxCocoa
import RxSwift

final class StudentSignUpViewModel: BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let emailText: ControlProperty<String?>
        let duplicationButtonTap: ControlEvent<Void>
        let nextButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let emailValdation: BehaviorSubject<Bool>
        let nextButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let emailValidation = BehaviorSubject<Bool>(value: false)
        
        /// 이메일 유효성 검사
        input.emailText.orEmpty
            .map { emailText in
                return ValidationManager.shared.emailValidation(emailText)
            }
            .bind { result in
                print("이메일 유효성 검사 결과", result)
                emailValidation.onNext(result)
            }
            .disposed(by: disposeBag)
        
        /// 이메일 중복 확인 버튼 탭
        input.duplicationButtonTap
            .withLatestFrom(input.emailText.orEmpty)
            .distinctUntilChanged()
            .flatMap { emailText in
                NetworkManager.shared.checkEmail(emailText)
            }
            .bind(with: self) { owner, result in
                print("이건 나오나")
                print(">>> Next", result)
                
                switch result {
                case .success(let value):
                    print(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(emailValdation: emailValidation,
                      nextButtonTap: input.nextButtonTap)
    }
    
}
