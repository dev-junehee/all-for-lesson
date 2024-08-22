//
//  LessonOpenViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonOpenViewController: BaseViewController {
    
    private let openView = LessonOpenView()
    private let viewModel = LessonOpenViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = openView
    }
    
    override func setViewController() {
        navigationItem.title = "새로운 레슨 개설하기"
        setImgBarButton(image: Resource.SystemImage.plus, target: self, action: #selector(lessonPlusButtonClicked), type: .right)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let input = LessonOpenViewModel.Input(
            majorFieldTap: openView.majorField.rx.controlEvent(.touchUpInside))
        let output = viewModel.transform(input: input)
        
        output.majorList
            .bind(to: openView.majorPicker.rx.itemTitles) { _, item in
                return item
            }
            .disposed(by: disposeBag)
        
        
    }
    
    @objc private func lessonPlusButtonClicked() {
        print("레슨 개설 버튼 클릭")
    }
    
    
}
