//
//  ViewModelType.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation

protocol InputOutput {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
