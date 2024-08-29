//
//  MyCommentViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation

final class MyCommentViewController: BaseViewController {
    
    private let myCommentView = MyCommentView()
    
    override func loadView() {
        view = myCommentView
    }
    
    override func setViewController() {
        navigationItem.title = "내가 작성한 후기"
        setBackBarButton()
    }
    
    
    
}
