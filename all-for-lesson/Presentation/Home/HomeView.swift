//
//  HomeView.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import SnapKit
import Then

final class HomeView: BaseView {
    
    lazy var logoView = UIView().then {
        $0.addSubview(logoButton)
        $0.backgroundColor = Resource.Color.white
    }
    
    let logoButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Resource.Color.fontBlack
        
        var title = AttributedString(Constant.allforlesson)
        title.font = Resource.Font.viewTitle
        config.attributedTitle = title

        /// 버튼 이미지
        config.image = .logo
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        $0.configuration = config
    }
    
    lazy var scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.addSubview(container)
    }
    
    lazy var container = UIView().then {
        $0.addSubview(menuCollectionView)
        $0.addSubview(popularLabel)
        $0.addSubview(popularCollectionView)
        $0.addSubview(interestingLabel)
        $0.addSubview(interestingCollectionView)
    }
    
    lazy var menuCollectionView = UICollectionView(frame: .zero, collectionViewLayout: menuLayout()).then {
        $0.register(HomeMenuCollectionViewCell.self, forCellWithReuseIdentifier: HomeMenuCollectionViewCell.id)
    }

    let popularLabel = UILabel().then {
        $0.text = Constant.Home.popular
        $0.font = Resource.Font.bold16
    }
    
    lazy var popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: lessonLayout()).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(HomeLessonCollectionViewCell.self, forCellWithReuseIdentifier: HomeLessonCollectionViewCell.id)
    }
    
    let interestingLabel = UILabel().then {
        $0.text = Constant.Home.interesting
        $0.font = Resource.Font.bold16
    }
    
    lazy var interestingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: lessonLayout()).then {
        $0.showsHorizontalScrollIndicator = false
        $0.register(HomeLessonCollectionViewCell.self, forCellWithReuseIdentifier: HomeLessonCollectionViewCell.id)
    }
    
    private func menuLayout() -> UICollectionViewLayout {
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
    
    private func lessonLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override func setHierarchyLayout() {
        [logoView, scrollView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        logoView.snp.makeConstraints {
            $0.top.equalTo(self).offset(60)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(50)
        }
        
        logoButton.snp.makeConstraints {
            $0.top.equalTo(logoView)
            $0.width.equalTo(160)
            $0.height.equalTo(40)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(interestingCollectionView.snp.bottom).offset(16)
        }
        
        menuCollectionView.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(container)
            $0.height.equalTo(180)
        }
        
        popularLabel.snp.makeConstraints {
            $0.top.equalTo(menuCollectionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(container).inset(16)
            $0.height.equalTo(20)
        }
        
        popularCollectionView.snp.makeConstraints {
            $0.top.equalTo(popularLabel.snp.bottom)
            $0.horizontalEdges.equalTo(container)
            $0.height.equalTo(220)
        }
        
        interestingLabel.snp.makeConstraints {
            $0.top.equalTo(popularCollectionView.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(container).inset(16)
            $0.height.equalTo(20)
        }
        
        interestingCollectionView.snp.makeConstraints {
            $0.top.equalTo(interestingLabel.snp.bottom)
            $0.horizontalEdges.equalTo(container)
            $0.height.equalTo(220)
        }
    }
    
}
