//
//  LessonDetailViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import Foundation

final class LessonDetailViewController: BaseViewController {
    
    private let detailView = LessonDetailView()
    
    override func loadView() {
        view = detailView
    }
    
}
