//
//  MyLessonEditViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyLessonEditViewController: BaseViewController {
    
    private let myLessonEditView = MyLessonEditView()
    private let viewModel = MyLessonEditViewModel()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        navigationItem.title = "레슨 수정"
        setBackBarButton()
    }
    
    private func bind() {
        let input = MyLessonEditViewModel.Input()
        let output = viewModel.transform(input: input)
        
        
        
    }
    
}
