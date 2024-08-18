//
//  HomeMenuTableViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit

final class HomeMenuTableViewCell: BaseTableViewCell {
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func setHierarchyLayout() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
}
