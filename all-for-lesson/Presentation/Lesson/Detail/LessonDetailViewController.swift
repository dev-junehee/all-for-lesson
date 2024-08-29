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
        setImgBarButton(image: Resource.Image.bookmarkFill, color: Resource.Color.whiteSmoke, action: nil, type: .right)
        toggleTabBar(isShow: false)
    }
    
    private func bind() {
        guard let bookmarkButton = navigationItem.rightBarButtonItem else { return }
        
        let input = LessonDetailViewModel.Input(
            postId: postId,
            bookmarkButtonTap: bookmarkButton.rx.tap,
            reservationButtonTap: detailView.reservationButton.rx.tap,
            infoControlTap: detailView.lessonInfoControl.rx.selectedSegmentIndex,
            commentText: detailView.commentFieldView.commentField.rx.text,
            commentButtonTap: detailView.commentFieldView.commentButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        /// 레슨 상세 데이터 바인딩
        output.detailInfo
            .bind(with: self) { owner, detailInfo in
                owner.detailView.updateLessonDetailInfo(detailInfo)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 후기 데이터 바인딩
        output.detailInfo
            .map { post in
                return post.comments
            }
            .bind(to: detailView.lessonCommentView.collectionView.rx.items(cellIdentifier: LessonCommentCollectionViewCell.id, cellType: LessonCommentCollectionViewCell.self)) { item, element, cell in
                print(element)
                cell.updateCell(comment: element)
            }
            .disposed(by: disposeBag)
        
        /// 북마크 결과
        output.isBookmark
            .bind(with: self) { owner, isBookmark in
                print("북마크 상태", isBookmark)
                if isBookmark {
                    owner.navigationItem.rightBarButtonItem?.tintColor = Resource.Color.purple
                } else {
                    owner.navigationItem.rightBarButtonItem?.tintColor = Resource.Color.white
                }
            }
            .disposed(by: disposeBag)
        
        /// 레슨 신청 결과
        output.isReservation
            .bind(with: self) { owner, isReservation in
                let title = AttributedString(isReservation ? "레슨 신청 취소" : "레슨 신청하기")
                let foregroundColor = isReservation ? Resource.Color.white : Resource.Color.fontBlack
                let backgroundColor = isReservation ? Resource.Color.purple : Resource.Color.yellow
                
                var config = owner.detailView.reservationButton.configuration
                config?.attributedTitle = title
                config?.attributedTitle?.font = Resource.Font.bold16
                config?.baseBackgroundColor = backgroundColor
                config?.baseForegroundColor = foregroundColor
                owner.detailView.reservationButton.configuration = config
            }
            .disposed(by: disposeBag)
        
        /// Segmented Control
        output.infoControlTap
            .bind(with: self) { owner, selectedIndex in
                owner.detailView.updateSegmentedControl(selectedIndex)
                owner.detailView.commentFieldView.isHidden = selectedIndex == 1 ? false : true
            }
            .disposed(by: disposeBag)
        
        /// 후기 댓글 결과
        output.commentDone
            .bind(with: self) { owner, success in
                if success {
                    owner.detailView.commentFieldView.commentField.text = ""
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func bookmarkButtonClicked() {
        
    }
    
}
