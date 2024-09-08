//
//  MyReservationController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyReservationViewController: BaseViewController {
    
    private let myReservationView = MyReservationBookmarkView()
    private let viewModel = MyReservationViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = myReservationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleTabBar(isShow: false)
    }
    
    override func setViewController() {
        navigationItem.title = "나의 수강 내역"
        setBackBarButton()
    }
    
    private func bind() {
        let viewWillAppearTrigger = self.rx.methodInvoked(#selector(self.viewWillAppear(_:)))
        
        let input = MyReservationViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger,
            reservationTap: myReservationView.collectionView.rx.modelSelected(PayValidationResponse.self)
        )
        let output = viewModel.transform(input: input)
        
        /// 나의 수강 내역 리스트 데이터 바인딩
        output.reservationList
            .bind(to: myReservationView.collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self)) { item, element, cell in
                // cell.updateCell(post: element)
                cell.updateCellWithPostID(element.post_id)
            }
            .disposed(by: disposeBag)
        
        /// 수강 내역 탭 - 화면 전환 + id 전달
        output.reservationTap
            .bind(with: self) { owner, postID in
                let lessonDetailVC = LessonDetailViewController()
                lessonDetailVC.postId.onNext(postID)
                owner.navigationController?.pushViewController(lessonDetailVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
