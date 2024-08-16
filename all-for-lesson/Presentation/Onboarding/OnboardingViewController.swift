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
    
    override func loadView() {
        view = onboardingView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("온보딩 화면 진입")
    }
    
    
}
