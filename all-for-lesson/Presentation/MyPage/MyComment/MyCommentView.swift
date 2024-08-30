//
//  MyCommentView.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import UIKit
import SnapKit
import Then

final class MyCommentView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(LessonCommentCollectionViewCell.self, forCellWithReuseIdentifier: LessonCommentCollectionViewCell.id)
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width / 4)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 32, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func setHierarchyLayout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.verticalEdges.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(16)
        }
    }

}
