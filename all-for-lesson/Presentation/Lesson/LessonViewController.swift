//
//  LessonViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit

final class LessonViewController: BaseViewController {
    
    private let lessonView = LessonView()
    
    override func loadView() {
        view = lessonView
    }
    
    override func setViewController() {
        navigationItem.title = "레슨찾기"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        /// 컬렉션뷰
        lessonView.collectionView.delegate = self
        lessonView.collectionView.dataSource = self
        lessonView.collectionView.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonCollectionViewCell.id)
    }
    
}

extension LessonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCollectionViewCell.id, for: indexPath) as? LessonCollectionViewCell else { return LessonCollectionViewCell() }
        
        cell.updateCell()
        
        return cell
    }
    
}
