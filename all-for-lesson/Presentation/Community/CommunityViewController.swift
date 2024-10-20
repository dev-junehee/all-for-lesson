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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewDidLoadTrigger.onNext(())
    }
    
    private func bind() {
        let input = CommunityViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger,
            postButtonTap: communityView.createButton.rx.tap
        )
        let output = viewModel.transform(input: input)
        
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
    }
    
}
