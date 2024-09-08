//
//  PaymentsViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 9/8/24.
//

import Foundation
import RxCocoa
import RxSwift

final class PaymentsViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let payBodyData: PublishSubject<PayValidationBody>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        input.payBodyData
            .flatMap { body in
                NetworkManager.shared.apiCall(api: .pay(.postValidation(body: body)), of: PayValidationResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("검증 성공")
                    print(value)
                case .failure(let error):
                    print("검증 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output()
    }
    
}
