//
//  HashTagViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import RxCocoa
import RxSwift

final class HashTagViewController: BaseViewController {
    
    private let hashtagView = HashTagView()
    private let viewModel = HashTagViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = hashtagView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleTabBar(isShow: true)
        hashtagView.searchTextField.text = ""
    }
    
    override func setViewController() {
        hashtagView.collectionView.delegate = self
    }
    
    private func bind() {
        let viewWillAppearTrigger = self.rx.methodInvoked(#selector(viewWillAppear(_:)))
        
        let input = HashTagViewModel.Input(
            viewWillAppearTrigger: viewWillAppearTrigger,
            searchText: hashtagView.searchTextField.rx.text,
            searchButtonTap: hashtagView.searchButton.rx.tap,
            hashtagButtonTap: hashtagView.collectionView.rx.modelSelected(String.self))
        let output = viewModel.transform(input: input)
        
        /// 추천 해시태그 셀 데이터 바인딩
        output.recommendHashtagList
            .bind(to: hashtagView.collectionView.rx.items(cellIdentifier: HashTagCollectionViewCell.id, cellType: HashTagCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(title: element)
            }
            .disposed(by: disposeBag)
        
        /// 해시태그 검색 결과 + 화면전환
        output.searchHashtagList
            .bind(with: self) { owner, searchList in
                let hashtagResultVC = HashTagResultViewController()
                hashtagResultVC.resultLessonVC.resultLessonData.onNext(searchList)  // 레슨
                hashtagResultVC.resultCommunityVC.resultCommunityData.onNext(searchList) // 커뮤니티
                owner.navigationController?.pushViewController(hashtagResultVC, animated: true)
            }
            .disposed(by: disposeBag)
    }
    
}

extension HashTagViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: .zero, height: 30) /// 추천 해시태그 셀 height 30으로 고정
    }
}

