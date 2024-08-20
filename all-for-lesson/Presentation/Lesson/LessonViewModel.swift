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
        let searchText: ControlProperty<String?>
    }
    
    struct Output {
        // let filteredLessonList: BehaviorSubject<[Post]>
    }
    
    func transform(input: Input) -> Output {
        // let lessonList = BehaviorSubject(value: [])
        // let filteredLessonList = BehaviorSubject(value: [])
        
   
        
        input.searchText
            .orEmpty
            .bind(with: self) { owner, searchText in
                // SearchText가 포함된 검색어만 필터링 -> filteredLessonList
                // filteredLessonList.onNext([])
            }
            .disposed(by: disposeBag)
            
        
        return Output()
    }
    
}
