//
//  TeacherSignUpViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class TeacherSignUpViewController: BaseViewController {
    
    private var signUpView = TeacherSignUpView()
    private var viewModel = TeacherSignUpViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
