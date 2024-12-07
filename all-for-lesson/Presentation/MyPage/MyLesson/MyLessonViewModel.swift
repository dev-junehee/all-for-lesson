//
//  MyLessonViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyLessonViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearTrigger: Observable<[Any]>
        let lessonTap: ControlEvent<Post>
    }
    
    struct Output {
        let myLessonList: PublishSubject<[Post]>
        let lessonTap: PublishSubject<Post>
    }
    
    func transform(input: Input) -> Output {
        let myLessonList = PublishSubject<[Post]>()
        let lessonTap = PublishSubject<Post>()
        
        /// 화면 로드 시 내가 개설한 레슨 불러오기
        input.viewWillAppearTrigger
            .flatMap { _ in
                let myID = UserDefaultsManager.userId
                let query = PostQuery(next: "", limit: "", product_id: ProductId.defaultId)
                return NetworkManager.shared.apiCall(api: .post(.getUserPosts(id: myID, query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("나의 레슨 데이터 불러오기 성공")
                    myLessonList.onNext(value.data)
                case .failure(let error):
                    print("나의 레슨 데이터 불러오기 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 레슨 탭 - 레슨 수정하기 화면 연결
        input.lessonTap
            .bind { post in
                lessonTap.onNext(post)
            }
            .disposed(by: disposeBag)
        
        return Output(myLessonList: myLessonList, 
                      lessonTap: lessonTap)
    }
    
}
