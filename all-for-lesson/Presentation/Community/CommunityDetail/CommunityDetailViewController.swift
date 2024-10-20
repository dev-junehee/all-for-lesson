//
//  CommunityDetailViewController.swift
//  all-for-lesson
//
//  Created by junehee on 10/20/24.
//

import Foundation

final class CommunityDetailViewController: BaseViewController {
    
    private let communityDetailView = CommunityDetailView()
    
    override func loadView() {
        view = communityDetailView
    }
    
    override func setViewController() {
        setBackBarButton()
    }
    
}
