//
//  LessonDetailViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonDetailViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let reservationButtonTap: ControlEvent<Void>
        let infoControlTap: ControlProperty<Int>
    }
    
    struct Output {
        let infoControlTap: BehaviorSubject<Int>
    }
    
    func transform(input: Input) -> Output {
        let infoControlTap = BehaviorSubject(value: 0)
        
        input.reservationButtonTap
            .bind { _ in
                print("레슨 신청 버튼 탭")
            }
            .disposed(by: disposeBag)
        
        input.infoControlTap
            .bind { idx in
                print("컨트롤 선택: ", idx)
                infoControlTap.onNext(idx)
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(infoControlTap: infoControlTap)
    }
    
    
    
}
