//
//  HomeMenuCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit
import SnapKit
import Then

final class HomeMenuCollectionViewCell: BaseCollectionViewCell {
    
    let menuButton = UIButton()
    
    let menuLabel = UILabel().then {
        $0.font = Resource.Font.medium12
        $0.textAlignment = .center
    }
    
    override func setHierarchyLayout() {
        [menuButton, menuLabel].forEach { contentView.addSubview($0) }
        
        menuButton.snp.makeConstraints {
            $0.top.centerX.equalTo(contentView)
            $0.width.equalTo(50)
            $0.bottom.equalTo(menuLabel.snp.top)
        }
        
        menuLabel.snp.makeConstraints {
            $0.horizontalEdges.centerX.equalTo(contentView)
            $0.height.equalTo(20)
        }
    }
    
    func updateCell(title: String, image: UIImage) {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = Resource.Color.paleGray
        config.cornerStyle = .small
        config.image = image
        config.imagePlacement = .top
        menuButton.configuration = config
        menuLabel.text = title
    }
    
    
}
