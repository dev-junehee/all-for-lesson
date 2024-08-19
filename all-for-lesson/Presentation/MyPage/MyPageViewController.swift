//
//  MyPageViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import SnapKit

final class MyPageViewController: BaseViewController {
    
    enum MyPageSection: CaseIterable {
        case general
        case personal
    }
    
    let menuList: [[MyPageMenu]] = [
        [MyPageMenu(title: "레슨 개설하기")],
        [MyPageMenu(title: "로그아웃"), MyPageMenu(title: "회원탈퇴")]
    ]
    private var dataSource: UICollectionViewDiffableDataSource<MyPageSection, MyPageMenu>!
        
    
    private let mypageView = MyPageView()
    
    override func loadView() {
        view = mypageView
    }
    
    // private let logoutButton = UIButton().then {
    //     $0.setTitle("(임시) 로그아웃", for: .normal)
    //     $0.backgroundColor = Resource.Color.purple
    // }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDataSource()
        updateSnapShot()
        
        // view.addSubview(logoutButton)
        // 
        // logoutButton.snp.makeConstraints {
        //     $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        //     $0.height.equalTo(60)
        //     $0.center.equalToSuperview()
        // }
        // 
        // logoutButton.addTarget(self, action: #selector(userTokenCheckTest), for: .touchUpInside)
    }
    
    override func setViewController() {
        navigationItem.title = "마이페이지"
        
        let barButton = UIBarButtonItem(image: Resource.SystemImage.gear, style: .plain, target: self, action: #selector(settingButtonClicked))
        barButton.tintColor = Resource.Color.darkGray
        navigationItem.rightBarButtonItem = barButton
    }
    
    /// 로그아웃 + 화면 전환 확인용 임시
    // @objc func userTokenCheckTest() {
    //     UserDefaultsManager.deleteAllUserDefaults() 
    //     NavigationManager.shared.changeRootViewControllerToLogin()
    // }
    
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
       snapshot.appendItems(menuList[0], toSection: .general)
       snapshot.appendItems(menuList[1], toSection: .personal)
       dataSource.apply(snapshot)
   }
    
}
