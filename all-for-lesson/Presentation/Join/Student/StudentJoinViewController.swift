//
//  StudentJoinViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import RxCocoa
import RxSwift

final class StudentJoinViewController: BaseViewController {
    
    private var joinView = StudentJoinView()
    private var viewModel = StudentJoinViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = joinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = StudentJoinViewModel.Input(emailText: joinView.emailField.rx.text,
                                               duplicationButtonTap: joinView.duplicationButton.rx.tap,
                                               passwordText: joinView.passwordField.rx.text,
                                               nickText: joinView.nickField.rx.text,
                                               joinButtonTap: joinView.joinButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        /// 이메일 유효성 검사 - 통과 시 중복 확인 버튼 활성화
        output.emailValdation
            .bind(with: self) { owner, result in
                // owner.joinView.validationResultLabel.text = result ? "이메일 중복 확인을 해주세요!" : ""
                // owner.joinView.validationResultLabel.textColor = .red
                owner.joinView.duplicationButton.isEnabled = result
                owner.joinView.duplicationButton.backgroundColor = result ? Resource.Color.skyblue : Resource.Color.lightGray
            }
            .disposed(by: disposeBag)
        
        /// 이메일 중복 확인 - 중복 확인 완료 레이블로 변경
        output.emailDuplication
            .bind(with: self) { owner, value in
                let code = value.0
                let message = value.1
                owner.joinView.validationResultLabel.text = message
                owner.joinView.validationResultLabel.textColor = code == 200 ? Resource.Color.skyblue : Resource.Color.red
            }
            .disposed(by: disposeBag)
        
        /// 최종 유효성 검사 (비밀번호 & 닉네임) - 가입 버튼 활성화
        output.validation
            .bind(with: self) { owner, result in
                owner.joinView.joinButton.isEnabled = result
            }
            .disposed(by: disposeBag)
        
        /// 회원가입 성공 - 화면 전환
        output.joinSucceed
            .bind(with: self) { owner, result in
                if result {
                    owner.navigationController?.pushViewController(HomeViewController(), animated: true)
                }
            }
            .disposed(by: disposeBag) 
        
    }
    
    
}
