//
//  LessonViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import RxCocoa
import RxSwift

final class LessonViewController: BaseViewController {
    
    private let lessonView = LessonView()
    private let viewModel = LessonViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = lessonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        let viewDidLoadTrigger = self.rx.methodInvoked(#selector(self.viewWillAppear(_:)))
        
        let input = LessonViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger,
                                          lessonTap: lessonView.collectionView.rx.modelSelected(Post.self))
        let output = viewModel.transform(input: input)
        
        output.lessonList
            .bind(to: lessonView.collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self)) { item, element, cell in
                cell.lessonTitle.text = element.content
                cell.lessonPrice.text = "129,000원"
                cell.starLate.text = "5.0"
            }
            .disposed(by: disposeBag)
        
        
        
    }
    
}
