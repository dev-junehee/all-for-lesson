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
    private let viewModel = CommunityDetailViewModel()
    private let disposeBag = DisposeBag()
    
    let postId = BehaviorSubject<String>(value: "")
    
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
        let input = CommunityDetailViewModel.Input(postId: postId)
        let output = viewModel.transform(input: input)
        
        output.communityDetail
            .bind(with: self) { owner, communityDetail in
                print("================")
                dump(communityDetail)
                owner.communityDetailView.updateCommunityDetailView(post: communityDetail)
            }
            .disposed(by: disposeBag)
        
        output.communityDetail
            .map { post in
                return post.comments
            }
            .bind(to: communityDetailView.collectionView.rx.items(cellIdentifier: CommunityCommentCollectionViewCell.id, cellType: CommunityCommentCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(comment: element)
            }
            .disposed(by: disposeBag)
        
    }
    
}
