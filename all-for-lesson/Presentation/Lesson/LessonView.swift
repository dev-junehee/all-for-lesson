//
//  LessonView.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit
import SnapKit
import Then

final class LessonView: BaseView {
 
    lazy var lessonTitleView = UIView().then {
        $0.addSubview(lessonTitleButton)
    }
    
    let lessonTitleButton = UIButton().then {
        $0.contentHorizontalAlignment = .leading
    }
    
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
    
    override func setHierarchyLayout() {
        [lessonTitleView, collectionView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        lessonTitleView.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(50)
        }
        
        lessonTitleButton.snp.makeConstraints {
            $0.top.equalTo(lessonTitleView)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(40)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(lessonTitleButton.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
}
