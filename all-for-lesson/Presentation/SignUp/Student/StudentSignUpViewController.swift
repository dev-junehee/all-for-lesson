//
//  StudentSignUpViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class StudentSignUpViewController: BaseViewController {
    
    private var signUpView = StudentSignUpView()
    private var viewModel = StudentSignUpViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = StudentSignUpViewModel.Input(emailText: signUpView.emailField.rx.text,
                                                duplicationButtonTap: signUpView.duplicationButton.rx.tap,
                                                nextButtonTap: signUpView.nextButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        /// 이메일 유효성 검사 > 중복 확인 버튼 활성화
        output.emailValdation
            .bind(with: self) { owner, result in
                owner.signUpView.validationResultLabel.text = result ? "이메일 중복 확인을 해주세요!" : ""
                owner.signUpView.validationResultLabel.textColor = .red
                owner.signUpView.duplicationButton.isEnabled = result
                owner.signUpView.duplicationButton.backgroundColor = result ? Resource.Color.skyblue : Resource.Color.lightGray
            }
            .disposed(by: disposeBag)
        
        /// 이메일 중복 확인 > 다음 버튼 활성화
        output.nextButtonTap
            .bind(with: self) { owner, _ in
                // owner.navigationController?.pushViewController(PasswordViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
    
}
