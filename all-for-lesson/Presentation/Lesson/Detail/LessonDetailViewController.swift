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
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        setBackBarButton()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    private func bind() {
        let input = LessonDetailViewModel.Input(
            reservationButtonTap: detailView.reservationButton.rx.tap, 
            infoControlTap: detailView.lessonInfoControl.rx.selectedSegmentIndex)
        let output = viewModel.transform(input: input)
        
        output.infoControlTap
            .bind(with: self) { owner, selectedIndex in
                owner.detailView.updateSegmentedControl(selectedIndex)
            }
            .disposed(by: disposeBag)
    }
    
}
