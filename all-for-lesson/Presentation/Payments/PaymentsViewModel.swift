//
//  PaymentsViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 9/1/24.
//

import Foundation
import RxCocoa
import RxSwift

final class PaymentsViewModel: InputOutput {
    
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Post>
    }
    
    struct Output {
        
    }
    
    func transform(input: Input) -> Output {
        
        
        return Output()
    }
    
}
