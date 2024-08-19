//
//  MyPageViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import SnapKit

final class MyPageViewController: BaseViewController {
    
    private enum MyPageSection: CaseIterable {
        case all
    }
    
    /// 임시 메뉴
    let menuList: [MyPageMenu] = [
        MyPageMenu(title: "레슨 개설하기"), 
        MyPageMenu(title: "로그아웃"),
        MyPageMenu(title: "회원탈퇴")
    ]
    
    private var dataSource: UICollectionViewDiffableDataSource<MyPageSection, MyPageMenu>!
        
    private let mypageView = MyPageView()
    
    override func loadView() {
        view = mypageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        updateSnapShot()
    }
    
    override func setViewController() {
        navigationItem.title = "마이페이지"
        
        let barButton = UIBarButtonItem(image: Resource.SystemImage.gear, style: .plain, target: self, action: #selector(settingButtonClicked))
        barButton.tintColor = Resource.Color.darkGray
        navigationItem.rightBarButtonItem = barButton
        
        mypageView.tableView.delegate = self
    }
    
    /// 설정 바버튼 클릭 (임시)
    @objc func settingButtonClicked() {
        
    }
    
}


// MARK: 메뉴 테이블뷰 (모던 컬렉션뷰 활용)
extension MyPageViewController {
    private func configureDataSource() {
       var registration: UICollectionView.CellRegistration<UICollectionViewListCell, MyPageMenu>!
       registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
           var content = UIListContentConfiguration.valueCell()
           content.text = itemIdentifier.title
           content.textProperties.font = Resource.Font.regular14 ?? UIFont.systemFont(ofSize: 14, weight: .regular)
           cell.indentationLevel = 1
           cell.contentConfiguration = content
       }
       
        dataSource = UICollectionViewDiffableDataSource(collectionView: mypageView.tableView, cellProvider: { collectionView, indexPath, itemIdentifier in
           let cell = collectionView.dequeueConfiguredReusableCell(
               using: registration,
               for: indexPath,
               item: itemIdentifier)
           return cell
       })
   }
   
   private func updateSnapShot() {
       var snapshot = NSDiffableDataSourceSnapshot<MyPageSection, MyPageMenu>()
       snapshot.appendSections(MyPageSection.allCases)
       snapshot.appendItems(menuList, toSection: .all)
       dataSource.apply(snapshot)
   }
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.row
        
        switch row {
        case 0:
            return
        case 1: // 로그아웃
            UserDefaultsManager.deleteAllUserDefaults()
            NavigationManager.shared.changeRootViewControllerToLogin()
        case 2:
            return
        default:
            return
        }
        
    }
}
