//
//  CommunityViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import Foundation
import RxCocoa
import RxSwift

final class CommunityViewController: BaseViewController {
    
    private let communityView = CommunityView()
    private let viewModel = CommunityViewModel()
    private let disposeBag = DisposeBag()
    
    private var viewDidLoadTrigger = PublishSubject<Void>()
    
    override func loadView() {
        view = communityView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewDidLoadTrigger.onNext(())
    }
    
    private func bind() {
        let input = CommunityViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger,
            postButtonTap: communityView.createButton.rx.tap,
            communityCellTap: communityView.collectionView.rx.modelSelected(Post.self)
        )
        let output = viewModel.transform(input: input)
        
        output.profileData
            .bind(with: self) { owner, profileData in
                owner.communityView.updateCommunityProfile(profileData)
            }
            .disposed(by: disposeBag)
        
        output.communityList
            .bind(to: communityView.collectionView.rx.items(cellIdentifier: CommunityCollectionViewCell.id, cellType: CommunityCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(post: element)
            }
            .disposed(by: disposeBag)
        
        output.postButtonTap
            .bind(with: self) { owner, _ in
                owner.present(CommunityPostViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        output.communityID
            .bind(with: self) { owner, id in
                let communityDetailVC = CommunityDetailViewController()
                // hashtagResultVC.resultLessonVC.resultLessonData.onNext(searchList)
                owner.navigationController?.pushViewController(communityDetailVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}
