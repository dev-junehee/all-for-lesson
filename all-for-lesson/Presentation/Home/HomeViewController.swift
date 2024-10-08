//
//  HomeViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    private let viewModel = HomeViewModel()
    private let disposeBag = DisposeBag()
        
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(UserDefaultsManager.email)
        print(UserDefaultsManager.nick)
        print(UserDefaultsManager.userId)
        print(UserDefaultsManager.accessToken)
        print(UserDefaultsManager.refreshToken)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func bind() {
        let viewWillAppearTrigger = self.rx.methodInvoked(#selector(viewWillAppear(_:)))
        
        let input = HomeViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger,
            menuButtonTap: homeView.menuCollectionView.rx.itemSelected,
            popularLessonTap: homeView.popularCollectionView.rx.modelSelected(Post.self),
            interestingLessonTap: homeView.interestingCollectionView.rx.modelSelected(Post.self))
        let output = viewModel.transform(input: input)
        
        let menu = (id: HomeMenuCollectionViewCell.id,
                    cellType: HomeMenuCollectionViewCell.self)
        let popular = (id: HomeLessonCollectionViewCell.id,
                       cellType: HomeLessonCollectionViewCell.self)
        let interesting = (id: HomeLessonCollectionViewCell.id,
                           cellType: HomeLessonCollectionViewCell.self)
        
        /// 홈 화면 상단 메뉴 컬렉션뷰
        output.menuItems
            .bind(to: homeView.menuCollectionView.rx.items(cellIdentifier: menu.id, cellType: menu.cellType)) { item, element, cell in
                cell.updateCell(title: element.0, image: element.1)
            }
            .disposed(by: disposeBag)
        
        /// 홈 화면 상단 메뉴 선택값
        output.selectedMenu
            .bind(with: self) { owner, selectedMenu in
                let lessonVC = LessonViewController()
                lessonVC.menuType.onNext(selectedMenu)
                owner.navigationController?.pushViewController(lessonVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 홈 화면 인기 레슨 컬렉션뷰
        output.popularLessonList
            .bind(to: homeView.popularCollectionView.rx.items(cellIdentifier: popular.id, cellType: popular.cellType)) { item, element, cell in
                cell.updateCell(post: element)
            }
            .disposed(by: disposeBag)
        
        /// 홈 화면 흥미 레슨 컬렉션뷰
        output.interestingLessonList
            .bind(to: homeView.interestingCollectionView.rx.items(cellIdentifier: interesting.id, cellType: interesting.cellType)) { item, element, cell in
                cell.updateCell(post: element)
            }
            .disposed(by: disposeBag)
        
        output.lessonID
            .bind(with: self) { owner, lessonID in
                let lessonDetailVC = LessonDetailViewController()
                lessonDetailVC.postId.onNext(lessonID)
                owner.navigationController?.pushViewController(lessonDetailVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
