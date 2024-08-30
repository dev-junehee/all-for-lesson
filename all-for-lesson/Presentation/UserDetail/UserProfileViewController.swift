//
//  UserProfileViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import Foundation
import RxCocoa
import RxSwift

final class UserProfileViewController: BaseViewController {
    
    private let userProfileView = UserProfileView()
    private let viewModel = UserProfileViewModel()
    private let disposeBag = DisposeBag()
    
    let userID = BehaviorSubject<String>(value: "")
    
    override func loadView() {
        view = userProfileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        setBackBarButton()
    }
    
    private func bind() {
        let input = UserProfileViewModel.Input(userID: userID)
        let output = viewModel.transform(input: input)
        
        output.userData
            .bind(with: self) { owner, userData in
                owner.userProfileView.updateUserProfile(user: userData)
            }
            .disposed(by: disposeBag)
    }
    
}
