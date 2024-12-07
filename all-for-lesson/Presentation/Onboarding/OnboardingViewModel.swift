//
//  OnboardingViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import RxCocoa
import RxSwift

final class OnboardingViewModel: ViewModelType {
    
    struct Input {
        let studentTap: ControlEvent<Void>
        let teacherTap: ControlEvent<Void>
        let loginTap: ControlEvent<Void>
    }
    
    struct Output {
        let studentTap: ControlEvent<Void>
        let teacherTap: ControlEvent<Void>
        let loginTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        return Output(studentTap: input.studentTap,
                      teacherTap: input.teacherTap,
                      loginTap: input.loginTap)
    }
    
}
