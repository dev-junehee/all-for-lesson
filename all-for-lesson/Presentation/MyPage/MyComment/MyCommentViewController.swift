//
//  MyCommentViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyCommentViewController: BaseViewController {
    
    private let myCommentView = MyCommentView()
    private let viewModel = MyCommentViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = myCommentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        navigationItem.title = Constant.MyPage.myLessonComment
        setBackBarButton()
        toggleTabBar(isShow: false)
    }
    
    private func bind() {
        let viewWillAppearTrigger = self.rx.methodInvoked(#selector(viewWillAppear(_:)))
        
        let input = MyCommentViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger)
        let output = viewModel.transform(input: input)
        
        /// 레슨 수강 후기 데이터 바인딩
        output.commentList
            .bind(to: myCommentView.collectionView.rx.items(cellIdentifier: LessonCommentCollectionViewCell.id, cellType: LessonCommentCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(comment: element)
            }
            .disposed(by: disposeBag)
    }
    
}
