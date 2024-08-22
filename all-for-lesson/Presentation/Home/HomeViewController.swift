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
        // print(UserDefaultsManager.userType)
        print(UserDefaultsManager.accessToken)
        print(UserDefaultsManager.refreshToken)
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func bind() {
        let viewDidLoadTrigger = self.rx.methodInvoked(#selector(viewDidLoad))
        
        let input = HomeViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger,
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
        
        /// 홈 화면 인기 레슨 컬렉션뷰
        output.popularLessonList
            .bind(to: homeView.popularCollectionView.rx.items(cellIdentifier: popular.id, cellType: popular.cellType)) { item, element, cell in
                cell.lessonTitle.text = element.content
                cell.lessonLocationPrice.text = "(서울) 129,000원"
                cell.starLate.text = "4.9"
            }
            .disposed(by: disposeBag)
        
        /// 홈 화면 흥미 레슨 컬렉션뷰
        output.interestingLessonList
            .bind(to: homeView.interestingCollectionView.rx.items(cellIdentifier: interesting.id, cellType: interesting.cellType)) { item, element, cell in
                cell.lessonTitle.text = element.content
                cell.lessonLocationPrice.text = "(서울) 129,000원"
                cell.starLate.text = "4.9"
            }
            .disposed(by: disposeBag)
        
        output.lessonData
            .bind(with: self) { owner, lessonData in
                owner.navigationController?.pushViewController(LessonDetailViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
