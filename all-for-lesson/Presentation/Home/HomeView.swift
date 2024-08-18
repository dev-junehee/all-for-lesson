//
//  HomeView.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import Then

final class HomeView: BaseView {
    
    lazy var logoView = UIView().then {
        $0.addSubview(logoButton)
        $0.backgroundColor = Resource.Color.white
    }
    
    let logoButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Resource.Color.fontBlack
        
        var title = AttributedString("올포레슨")
        title.font = Resource.Font.viewTitle
        config.attributedTitle = title

        /// 버튼 이미지
        config.image = .noteIcon
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        $0.configuration = config
    }
    
    let tableView = UITableView()
    
    override func setHierarchyLayout() {
        [logoView, tableView].forEach { self.addSubview($0) }
        
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
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
        
        /// 임시
        tableView.backgroundColor = .gray
    }
    
}
