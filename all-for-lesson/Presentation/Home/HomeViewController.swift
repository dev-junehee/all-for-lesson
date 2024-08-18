//
//  HomeViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import UIKit

final class HomeViewController: BaseViewController {
    
    private let homeView = HomeView()
    
    
    
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(UserDefaultsManager.email)
        print(UserDefaultsManager.nick)
        print(UserDefaultsManager.userId)
        // print(UserDefaultsManager.userType)
        print(UserDefaultsManager.accessToken)
        print(UserDefaultsManager.refreshToken)
        
    }
    
    override func setViewController() {
        homeView.tableView.delegate = self
        homeView.tableView.dataSource = self
        homeView.tableView.register(HomeMenuTableViewCell.self, forCellReuseIdentifier: HomeMenuTableViewCell.id)
        homeView.tableView.register(HomeLessonTableViewCell.self, forCellReuseIdentifier: HomeLessonTableViewCell.id)
        homeView.tableView.separatorStyle = .none
        
    }
    
}

// MARK: 전체 스크롤 - 테이블뷰
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 160
        } else {
            return 260
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeMenuTableViewCell.id, for: indexPath) as? HomeMenuTableViewCell else { return HomeMenuTableViewCell() }
            
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(HomeMenuCollectionViewCell.self, forCellWithReuseIdentifier: HomeMenuCollectionViewCell.id)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.reloadData()
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeLessonTableViewCell.id, for: indexPath) as? HomeLessonTableViewCell else { return HomeLessonTableViewCell() }
        
            /// 2~3번째 테이블뷰 셀 타이틀 설정
            let title = ["", "실시간 인기 레슨", "이걸 배워? 신박한 레슨!"][indexPath.row]
            cell.setCellTitle(title)
            
            /// 2~3번째 테이블뷰 셀 - 컬렉션뷰 연결
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            cell.collectionView.register(HomeLessonCollectionViewCell.self, forCellWithReuseIdentifier: HomeLessonCollectionViewCell.id)
            cell.collectionView.tag = indexPath.row
            cell.collectionView.reloadData()
            
            return cell
        }
    }
}


// MARK: 컬렉션뷰
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag = collectionView.tag
        return tag == 0 ? 8 : 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag = collectionView.tag
        
        if tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeMenuCollectionViewCell.id, for: indexPath) as? HomeMenuCollectionViewCell else { return HomeMenuCollectionViewCell() }
            
            cell.updateCell()
            
            return cell
            
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeLessonCollectionViewCell.id, for: indexPath) as? HomeLessonCollectionViewCell else { return HomeLessonCollectionViewCell() }
            
            cell.updateCell(title: "[취미] 성인 바이올린 레슨")

            return cell
        }
    }
}
