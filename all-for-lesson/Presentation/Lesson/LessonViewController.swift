//
//  LessonViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import RxCocoa
import RxSwift

final class LessonViewController: BaseViewController {
    
    private let lessonView = LessonView()
    private let viewModel = LessonViewModel()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = lessonView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        navigationItem.title = "레슨찾기"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
        /// 컬렉션뷰
        // lessonView.collectionView.delegate = self
        // lessonView.collectionView.dataSource = self
        lessonView.collectionView.register(LessonCollectionViewCell.self, forCellWithReuseIdentifier: LessonCollectionViewCell.id)
    }
    
    private func bind() {
        let input = LessonViewModel.Input(viewDidLoadTrigger: self.rx.methodInvoked(#selector(self.viewWillAppear(_:))),
                                          searchText: lessonView.searchBar.rx.text)
        let output = viewModel.transform(input: input)
        
        // output.filteredLessonList
        //     .bind(to: lessonView.collectionView.rx.items(cellIdentifier: LessonCollectionViewCell.id, cellType: LessonCollectionViewCell.self))
        
        
        
    }
    
}

// extension LessonViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//         return 10
//     }
//     
//     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LessonCollectionViewCell.id, for: indexPath) as? LessonCollectionViewCell else { return LessonCollectionViewCell() }
//         
//         cell.updateCell()
//         
//         return cell
//     }
//     
// }
