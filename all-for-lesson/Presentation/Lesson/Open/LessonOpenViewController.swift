//
//  LessonOpenViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation

final class LessonOpenViewController: BaseViewController {
    
    private let lessonOpenView = LessonOpenView()
    
    override func loadView() {
        view = lessonOpenView
    }
    
    
}
