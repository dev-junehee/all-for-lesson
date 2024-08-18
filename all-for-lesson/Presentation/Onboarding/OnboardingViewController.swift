//
//  OnboardingViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import RxCocoa
import RxSwift

final class OnboardingViewController: BaseViewController {
    
    private let onboardingView = OnboardingView()
    private let viewModel = OnboardingViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = OnboardingViewModel.Input(studentTap: onboardingView.studentButton.rx.tap,
                                              teacherTap: onboardingView.teacherButton.rx.tap,
                                              loginTap: onboardingView.loginButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.studentTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(StudentJoinViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        output.teacherTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(TeacherJoinViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        output.loginTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(LoginViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
