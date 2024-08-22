//
//  LessonOpenViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonOpenViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let majorFieldTap: ControlEvent<Void>
    }
    
    struct Output {
        let majorButtonTap: ControlEvent<Void>
        let majorList: Observable<[String]>
    }
    
    func transform(input: Input) -> Output {
        let majorList = PublishSubject<[String]>()
        
        input.majorFieldTap
            .bind { _ in
                print("레슨 과목 버튼 클릭")
                majorList.onNext(["바이올린", "비올라", "첼로", "콘트라베이스"])
            }
            .disposed(by: disposeBag)
        
        return Output(majorButtonTap: input.majorFieldTap,
                      majorList: majorList)
    }
    
}
