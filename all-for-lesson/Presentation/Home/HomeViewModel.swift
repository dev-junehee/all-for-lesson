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
        let viewWillAppearTrigger: Observable<[Any]>
        let menuButtonTap: ControlEvent<IndexPath>
        let popularLessonTap: ControlEvent<Post>
        let interestingLessonTap: ControlEvent<Post>
    }
    
    struct Output {
        let menuItems: Observable<[(String, UIImage)]>
        let selectedMenu: PublishSubject<HomeMenuCase>
        let popularLessonList: BehaviorSubject<[Post]>       /// 컬렉션뷰 바인딩용
        let interestingLessonList: BehaviorSubject<[Post]>   /// 컬렉션뷰 바인딩용
        let lessonID: PublishSubject<String>
    }
    
    func transform(input: Input) -> Output {
        let menuItems = Observable.zip(Observable.just(Constant.Home.menu),
                                       Observable.just(Resource.Image.homeMenus))
                        .map { (titles, images) -> [(String, UIImage)] in
                            return Array(zip(titles, images))
                        }
        let selectedMenu = PublishSubject<HomeMenuCase>()
        let popularLessonList = BehaviorSubject<[Post]>(value: [])
        let interestingLessonList = BehaviorSubject<[Post]>(value: [])
        let lessonID = PublishSubject<String>()
        
        /// 화면이 나타날 때 마다 인기레슨/흥미레슨 불러오기
        input.viewWillAppearTrigger
            .flatMap { _ in
                let query = PostQuery(next: "", limit: "", product_id: ProductId.defaultId)
                return NetworkManager.shared.apiCall(api: .post(.getPosts(query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let response):
                    print("홈 화면 네트워크 연결 성공")
                    let popular = response.data.filter { $0.content4 == ProductId.popular }
                    let interesting = response.data.filter { $0.content4 == ProductId.interesting }
                    popularLessonList.onNext(popular)
                    interestingLessonList.onNext(interesting)
                case .failure(let error):
                    print("홈 화면 네트워크 연결 실패")
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 메뉴 버튼 탭 이벤트
        input.menuButtonTap
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .compactMap { indexPath in
                return HomeMenuCase(rawValue: indexPath.row)
            }
            .bind { selected in
                selectedMenu.onNext(selected)
            }
            .disposed(by: disposeBag)
        
        /// 인기 레슨 탭
        input.popularLessonTap
            .bind { post in
                lessonID.onNext(post.post_id)
            }
            .disposed(by: disposeBag)
        
        /// 흥미 레슨 탭
        input.interestingLessonTap
            .bind { post in
                lessonID.onNext(post.post_id)
            }
            .disposed(by: disposeBag)
        
        
        return Output(menuItems: menuItems, 
                      selectedMenu: selectedMenu,
                      popularLessonList: popularLessonList,
                      interestingLessonList: interestingLessonList,
                      lessonID: lessonID)
    }
    
}
