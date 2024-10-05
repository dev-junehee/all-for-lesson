//
//  HashTagDetailViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/31/24.
//

import UIKit
import Pageboy
import RxCocoa
import RxSwift
import Tabman

final class HashTagResultViewController: TabmanViewController {
   
    let resultLessonVC = HashTagResultLessonViewController()
    let resultCommunityVC = HashTagResultCommunityViewController()
    
    private lazy var subViewControllers = [resultLessonVC, resultCommunityVC]
    
    private let viewModel = HashTagResultViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewController()
    }
    
    private func setViewController() {
        view.backgroundColor = Resource.Color.white
        navigationItem.title = "검색 결과"
        setBackBarButton()
        setTabMan()
    }
    
    private func setTabMan() {
        self.dataSource = self
        let bar = TMBar.ButtonBar()
        bar.layout.transitionStyle = .snap
        bar.layout.alignment = .centerDistributed
        bar.layout.contentMode = .fit
        bar.tintColor = Resource.Color.purple
        bar.buttons.customize { button in
            button.selectedTintColor = Resource.Color.purple
            button.font = Resource.Font.bold16 ?? .boldSystemFont(ofSize: 16)
        }
        addBar(bar, dataSource: self, at: .top)
    }
}

extension HashTagResultViewController: PageboyViewControllerDataSource, TMBarDataSource {
    func numberOfViewControllers(in pageboyViewController: Pageboy.PageboyViewController) -> Int {
        return subViewControllers.count
    }
    
    func viewController(for pageboyViewController: Pageboy.PageboyViewController, at index: Pageboy.PageboyViewController.PageIndex) -> UIViewController? {
        return subViewControllers[index]
    }
    
    func defaultPage(for pageboyViewController: Pageboy.PageboyViewController) -> Pageboy.PageboyViewController.Page? {
        return nil
    }
    
    func barItem(for bar: any Tabman.TMBar, at index: Int) -> any Tabman.TMBarItemable {
        switch index {
        case 0: TMBarItem(title: "레슨")
        case 1: TMBarItem(title: "커뮤니티")
        default: TMBarItem(title: "\(index)")
        }
    }
}
