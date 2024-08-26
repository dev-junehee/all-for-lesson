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
        let menuType: BehaviorSubject<HomeMenuCase?>
        let lessonTap: ControlEvent<Post>
    }
    
    struct Output {
        let lessonViewTitle: Observable<(Int, String)>
        let lessonList: BehaviorSubject<[Post]>
    }
    
    func transform(input: Input) -> Output {
        let lessonViewTitle = BehaviorSubject(value: (0, ""))
        let lessonList = BehaviorSubject(value: postDummy)
        
        /// 레슨 검색 대상 (menuType) - 타이틀 텍스트 수정
        input.menuType
            .compactMap { menuCase in
                return menuCase?.rawValue
            }
            .bind { idx in
                print("idx", idx)
                let titleText = Constant.Home.menu[idx]
                lessonViewTitle.onNext((idx, titleText))
            }
            .disposed(by: disposeBag)
        
        /// 레슨 검색 결과 탭
        input.lessonTap
            .bind { postData in
                print(postData)
            }
            .disposed(by: disposeBag)
        
        return Output(lessonViewTitle: lessonViewTitle,
                      lessonList: lessonList)
    }
    
}
