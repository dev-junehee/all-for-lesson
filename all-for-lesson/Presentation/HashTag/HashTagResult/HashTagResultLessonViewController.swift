//
//  HashTagResultLessonViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/31/24.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class HashTagResultLessonViewController: BaseViewController {

    let resultLessonData = BehaviorSubject<[Post]>(value: [])
    private let disposeBag = DisposeBag()
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonCollectionViewCell.id)
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 20, height: width / 3.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        view.addSubview(collectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(16)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    private func bind() {
        /// 검색결과 (레슨) 데이터 바인딩
        resultLessonData
            .bind(to: collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self)) { item, element, cell in
                cell.updateCell(post: element)
            }
            .disposed(by: disposeBag)
    }
    
}
