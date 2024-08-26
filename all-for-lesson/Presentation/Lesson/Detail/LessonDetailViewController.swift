//
//  LessonDetailViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonDetailViewController: BaseViewController {
    
    private let detailView = LessonDetailView()
    private let viewModel = LessonDetailViewModel()
    private let disposeBag = DisposeBag()
    
    let postId = BehaviorSubject<String>(value: "")
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        setBackBarButton(Resource.Color.whiteSmoke)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func bind() {
        let input = LessonDetailViewModel.Input(
            postId: postId,
            reservationButtonTap: detailView.reservationButton.rx.tap,
            infoControlTap: detailView.lessonInfoControl.rx.selectedSegmentIndex)
        let output = viewModel.transform(input: input)
        
        /// 레슨 상세 데이터 바인딩
        output.detailInfo
            .bind(with: self) { owner, detailInfo in
                owner.detailView.updateLessonDetailInfo(detailInfo)
            }
            .disposed(by: disposeBag)
        
        output.infoControlTap
            .bind(with: self) { owner, selectedIndex in
                owner.detailView.updateSegmentedControl(selectedIndex)
            }
            .disposed(by: disposeBag)
    }
    
}
