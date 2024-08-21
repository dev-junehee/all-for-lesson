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
        let popularLessonTap: ControlEvent<Post>
        let interestingLessonTap: ControlEvent<Post>
    }
    
    struct Output {
        let menuItems: Observable<[(String, UIImage)]>
        let popularLessonList: BehaviorSubject<[Post]>       /// 컬렉션뷰 바인딩용
        let interestingLessonList: BehaviorSubject<[Post]>   /// 컬렉션뷰 바인딩용
        let lessonData: PublishSubject<Post>
    }
    
    func transform(input: Input) -> Output {
        let menuItems = Observable.zip(Observable.just(Constant.Home.menu),
                                       Observable.just(Resource.SystemImage.homeMenus))
                        .map { (titles, images) -> [(String, UIImage)] in
                            return Array(zip(titles, images))
                        }
        let popularLessonList = BehaviorSubject(value: postDummy)
        let interestingLessonList = BehaviorSubject(value: postDummy)
        let lessonData = PublishSubject<Post>()
        
        /// 메뉴 버튼 탭 이벤트
        input.menuButtonTap
            .bind { indexPath in
                print(indexPath)
            }
            .disposed(by: disposeBag)
        
        /// 인기 레슨 탭
        input.popularLessonTap
            .bind { data in
                lessonData.onNext(data)
            }
            .disposed(by: disposeBag)
        
        /// 흥미 레슨 탭
        input.interestingLessonTap
            .bind { data in
                lessonData.onNext(data)
            }
            .disposed(by: disposeBag)
        
        
        return Output(menuItems: menuItems,
                      popularLessonList: popularLessonList,
                      interestingLessonList: interestingLessonList,
                      lessonData: lessonData)
    }
    
}
