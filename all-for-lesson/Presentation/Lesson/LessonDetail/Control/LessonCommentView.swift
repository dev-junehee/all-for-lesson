//
//  LessonCommentView.swift
//  all-for-lesson
//
//  Created by junehee on 8/27/24.
//

import UIKit
import SnapKit
import Then

/**
 레슨 상세 화면 - 레슨 후기 - 댓글 컬렉션뷰
 */
final class LessonCommentView: BaseView {
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(LessonCommentCollectionViewCell.self, forCellWithReuseIdentifier: LessonCommentCollectionViewCell.id)
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width / 5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func setHierarchyLayout() {
        self.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
