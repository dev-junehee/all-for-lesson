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
    
    /// 홈 화면에서 선택한 메뉴
    var menuType = BehaviorSubject<HomeMenuCase?>(value: nil)
    
    override func loadView() {
        view = lessonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("선택한 메뉴", menuType)
        bind()
    }
    
    override func setViewController() {
        setBackBarButton()
    }
    
    private func bind() {
        let input = LessonViewModel.Input(
            menuType: menuType,
            lessonTap: lessonView.collectionView.rx.modelSelected(Post.self))
        let output = viewModel.transform(input: input)
        
        output.lessonViewTitle
            .map{ (idx, titleText) in
                if idx == 0 {
                    return (idx, titleText)
                } else {
                    return (idx, "`\(titleText)` 레슨을 찾고 있어요")
                }
            }
            .bind(with: self) { owner, viewTitle in
                let idx = viewTitle.0
                let titleText = viewTitle.1
                
                var config = UIButton.Configuration.plain()
                config.baseForegroundColor = Resource.Color.fontBlack
                
                config.image = Resource.Image.homeMenus[idx]
                config.imagePlacement = .leading
                config.imagePadding = 10
                
                var title = AttributedString(titleText)
                title.font = Resource.Font.bold20
                config.attributedTitle = title
                owner.lessonView.lessonTitleButton.configuration = config
            }
            .disposed(by: disposeBag)
        
        /// 결과 카운팅 레이블 데이터 바인딩
        output.lessonList
            .bind(with: self) { owner, lessonList in
                owner.lessonView.lessonCount.text = "총 \(lessonList.count.formatted())개 결과 "
            }
            .disposed(by: disposeBag)
        
        /// 레슨 셀 데이터 바인딩
        output.lessonList
            .bind(to: lessonView.collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(post: element)
            }
            .disposed(by: disposeBag)
        
        
        
    }
    
}
