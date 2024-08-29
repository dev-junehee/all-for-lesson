//
//  MyLessonViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import UIKit
import RxCocoa
import RxSwift

final class MyLessonViewController: BaseViewController {
    
    private let myLessonView = MyLessonView()
    private let viewModel = MyLessonViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = myLessonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        navigationItem.title = "나의 레슨 관리"
        setBackBarButton()
    }
    
    private func bind() {
        let viewWillAppearTrigger = self.rx.methodInvoked(#selector(self.viewWillAppear(_:)))
        
        let input = MyLessonViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger,
            lessonTap: myLessonView.collectionView.rx.modelSelected(Post.self))
        let output = viewModel.transform(input: input)
        
        output.myLessonList
            .bind(to: myLessonView.collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(post: element, isTeacher: true)
            }
            .disposed(by: disposeBag)
        
        output.lessonTap
            .bind(with: self) { owner, post in
                let lessonEditVC = MyLessonEditViewController()
                lessonEditVC.updateLessonEditView(post: post)
                owner.present(UINavigationController(rootViewController: lessonEditVC), animated: true)
            }
            .disposed(by: disposeBag)
        
    }
    
}
