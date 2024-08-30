//
//  UserProfileViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import Foundation
import RxCocoa
import RxSwift

final class UserProfileViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let userID: BehaviorSubject<String>
    }
    
    struct Output {
        let userData: PublishSubject<UserProfileResponse>
    }
    
    func transform(input: Input) -> Output {
        let userData = PublishSubject<UserProfileResponse>()
        
        input.userID
            .flatMap { id in
                NetworkManager.shared.apiCall(api: .user(.getUserProfile(id: id)), of: UserProfileResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("유저 프로필 조회 성공")
                    print(value)
                    userData.onNext(value)
                case .failure(let error):
                    print("유저 프로필 조회 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(userData: userData)
    }
    
    
}
