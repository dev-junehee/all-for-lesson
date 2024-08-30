//
//  HashTagCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import UIKit
import SnapKit
import Then

final class HashTagCollectionViewCell: BaseCollectionViewCell {
    
    private let hashtagButton = UIButton().then {
        var config = UIButton.Configuration.borderedTinted()
        config.baseBackgroundColor = Resource.Color.skyblue
        config.baseForegroundColor = Resource.Color.fontBlack
        config.cornerStyle = .capsule
        config.background.strokeColor = Resource.Color.paleGray
        config.background.strokeWidth = 1
        
        var title = AttributedString("")
        title.font = Resource.Font.regular14
        config.attributedTitle = title
        
        $0.configuration = config
    }
    
    override func setHierarchyLayout() {
        contentView.addSubview(hashtagButton)
        
        hashtagButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func updateCell(title: String) {
        var title = AttributedString(title)
        title.font = Resource.Font.regular14
        hashtagButton.configuration?.attributedTitle = title
    }
    
}

