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
    
    let searchBar = UISearchBar().then {
        $0.placeholder = "원하는 레슨을 검색해 보세요!"
        $0.searchBarStyle = .minimal
    }
    
    let lessonCount = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.text = "총 11,456개 결과"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
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
        [searchBar, lessonCount, collectionView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(8)
            $0.height.equalTo(44)
        }
        
        lessonCount.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(lessonCount.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
}
