//
//  PaymentsViewController.swift
//  all-for-lesson
//
//  Created by junehee on 9/1/24.
//

import Foundation
import RxCocoa
import RxSwift

final class PaymentsViewController: BaseViewController {
    
    private let paymentsView = PaymentsView()
    private let viewModel = PaymentsViewModel()
    
    private var viewDidLoadTrigger = PublishSubject<Post>()
    
    let postData = BehaviorSubject<Post?>(value: nil)
    
    override func loadView() {
        view = paymentsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = PaymentsViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger)
        let output = viewModel.transform(input: input)
    }
    
}
