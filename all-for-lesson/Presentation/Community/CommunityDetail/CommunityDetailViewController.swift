//
//  CommunityDetailViewController.swift
//  all-for-lesson
//
//  Created by junehee on 10/20/24.
//

import Foundation
import RxCocoa
import RxSwift

final class CommunityDetailViewController: BaseViewController {
    
    private let communityDetailView = CommunityDetailView()
    private let viewModel = CommunityViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = communityDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
    }
    
    override func setViewController() {
        setBackBarButton()
        bind()
    }
    
    private func bind() {
        
    }
    
}
