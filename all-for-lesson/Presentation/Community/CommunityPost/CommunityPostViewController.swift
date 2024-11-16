//
//  CommunityPostViewController.swift
//  all-for-lesson
//
//  Created by junehee on 10/20/24.
//

import Foundation

final class CommunityPostViewController: BaseViewController {
    
    private let communityPostView = CommunityPostView()
    
    override func loadView() {
        view = communityPostView
    }
    
    
}
