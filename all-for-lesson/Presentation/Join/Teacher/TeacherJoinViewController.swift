//
//  TeacherJoinViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class TeacherJoinViewController: BaseViewController {
    
    private var signUpView = TeacherJoinView()
    private var viewModel = TeacherJoinViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = signUpView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
