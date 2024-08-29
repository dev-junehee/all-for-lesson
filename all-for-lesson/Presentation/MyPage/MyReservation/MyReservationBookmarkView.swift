//
//  MyReservationView.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import UIKit
import SnapKit
import Then

final class MyReservationBookmarkView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonCollectionViewCell.id)
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 20, height: width / 3.5)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func setHierarchyLayout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    
}
