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
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Resource.Color.fontBlack
        
        config.image = .brass
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        var title = AttributedString("레슨찾기")
        title.font = Resource.Font.viewTitle
        config.attributedTitle = title
        $0.configuration = config
    }
    
    let lessonCount = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.text = "총 11,456개 결과"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonCollectionViewCell.id)
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width - 20, height: width / 3.5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func setHierarchyLayout() {
        [lessonTitleView, lessonCount, collectionView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        lessonTitleView.snp.makeConstraints {
            $0.top.equalTo(self).offset(60)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(50)
        }
        
        lessonTitleButton.snp.makeConstraints {
            $0.top.equalTo(lessonTitleView)
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        
        lessonCount.snp.makeConstraints {
            $0.top.equalTo(lessonTitleView.snp.bottom).offset(8)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(lessonCount.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
}
