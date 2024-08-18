//
//  HomeTableViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import SnapKit
import Then

final class HomeLessonTableViewCell: BaseTableViewCell {
    
    private let titleLabel = UILabel().then {
        $0.font = Resource.Font.bold18
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, 
                                               collectionViewLayout: layout())
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    override func setHierarchyLayout() {
        [titleLabel, collectionView].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.bottom.equalTo(contentView)
        }
    }
    
    func setCellTitle(_ title: String) {
        titleLabel.text = title
    }
    
}
