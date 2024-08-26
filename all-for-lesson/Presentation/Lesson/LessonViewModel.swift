//
//  LessonViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonViewModel: InputOutput {
    
    private let disposeBag =  DisposeBag()
    
    struct Input {
        let viewDidLoadTrigger: Observable<[Any]>
        let lessonTap: ControlEvent<Post>
    }
    
    struct Output {
        let lessonList: BehaviorSubject<[Post]>
    }
    
    func transform(input: Input) -> Output {
        let lessonList = BehaviorSubject(value: postDummy)
        
        /// 레슨 검색 결과 탭
        input.lessonTap
            .bind { postData in
                print(postData)
            }
            .disposed(by: disposeBag)
        
        return Output(lessonList: lessonList)
    }
    
}
