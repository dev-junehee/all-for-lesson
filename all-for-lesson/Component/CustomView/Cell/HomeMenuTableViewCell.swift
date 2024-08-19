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
        
        let sectionSpaciing: CGFloat = 16
        let cellSpacing: CGFloat = 16
        
        let width = UIScreen.main.bounds.width - (sectionSpaciing) - (cellSpacing)
        layout.itemSize = CGSize(width: width / 5, height: width / 5)
        layout.scrollDirection = .vertical
        
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpaciing, left: sectionSpaciing, bottom: sectionSpaciing, right: sectionSpaciing)
        
        return layout
    }
    
    override func setHierarchyLayout() {
        contentView.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
}
