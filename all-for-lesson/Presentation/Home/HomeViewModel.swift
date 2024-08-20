//
//  HomeViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import UIKit
import RxCocoa
import RxSwift

final class HomeViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoadTrigger: Observable<[Any]>
        let menuButtonTap: ControlEvent<IndexPath>
    }
    
    struct Output {
        let menuItems: Observable<[(String, UIImage)]>
        let popularLessonList: BehaviorSubject<[Post]>
        let interestingLessonList: BehaviorSubject<[Post]>
        // let menuImage: BehaviorSubject<[UIImage]>
        // let popularLessonList: PublishSubject<[String]>
        // let interestingLessonList: PublishSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        let menuItems = Observable.zip(Observable.just(Constant.Home.menu),
                                       Observable.just(Resource.SystemImage.homeMenus))
                        .map { (titles, images) -> [(String, UIImage)] in
                            return Array(zip(titles, images))
                        }
        let popularLessonList = BehaviorSubject(value: postDummy)
        let interestingLessonList = BehaviorSubject(value: postDummy)
        
        /// 메뉴 버튼 탭 이벤트
        input.menuButtonTap
            .bind { indexPath in
                print(indexPath)
            }
            .disposed(by: disposeBag)
        
        return Output(menuItems: menuItems,
                      popularLessonList: popularLessonList,
                      interestingLessonList: interestingLessonList)
    }
    
}
