//
//  MyBookmarkViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyBookmarkViewController: BaseViewController {
    
    private let myBookmarkView = MyReservationBookmarkView()
    private let viewModel = MyBookmarkViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = myBookmarkView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        navigationItem.title = Constant.MyPage.myBookmark
        setBackBarButton()
        toggleTabBar(isShow: false)
    }
    
    private func bind() {
        let viewWillAppearTrigger = self.rx.methodInvoked(#selector(self.viewWillAppear(_:)))
        
        let input = MyBookmarkViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger,
            bookmarkTap: myBookmarkView.collectionView.rx.modelSelected(Post.self)
        )
        let output = viewModel.transform(input: input)
        
        /// 나의 수강 내역 리스트 데이터 바인딩
        output.bookmarkList
            .bind(to: myBookmarkView.collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(post: element)
            }
            .disposed(by: disposeBag)
        
        /// 수강 내역 탭 - 화면 전환 + id 전달
        output.bookmarkTap
            .bind(with: self) { owner, postID in
                let lessonDetailVC = LessonDetailViewController()
                lessonDetailVC.postId.onNext(postID)
                owner.navigationController?.pushViewController(lessonDetailVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
