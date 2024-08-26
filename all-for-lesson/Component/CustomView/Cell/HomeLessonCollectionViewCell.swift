//
//  HomeLessonCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class HomeLessonCollectionViewCell: BaseCollectionViewCell {
    
    let lessonImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = Resource.Color.paleGray
    }
    
    let lessonTitle = UILabel().then {
        $0.font = Resource.Font.bold16
    }
    
    let lessonLocationPrice = UILabel().then {
        $0.font = Resource.Font.regular14
    }
    
    private let starImage = UIImageView().then {
        $0.image = Resource.SystemImage.star
        $0.tintColor = Resource.Color.yellow
    }
    
    let starLate = UILabel().then {
        $0.font = Resource.Font.regular12
    }
    
    override func setHierarchyLayout() {
        [lessonImage, lessonTitle, lessonLocationPrice, starImage, starLate].forEach { contentView.addSubview($0) }
        
        lessonImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(140)
        }
        
        lessonTitle.snp.makeConstraints {
            $0.top.equalTo(lessonImage.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(20)
        }
        
        lessonLocationPrice.snp.makeConstraints {
            $0.top.equalTo(lessonTitle.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(20)
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(lessonLocationPrice.snp.bottom).offset(4)
            $0.leading.equalTo(contentView)
            $0.size.equalTo(16)
        }
        
        starLate.snp.makeConstraints {
            $0.top.equalTo(lessonLocationPrice.snp.bottom).offset(4)
            $0.leading.equalTo(starImage.snp.trailing)
            $0.trailing.equalTo(contentView)
            $0.height.equalTo(16)
        }
    }
    
    func updateCell(post: Post) {
        guard let image = post.files.first else { return }
        NetworkManager.shared.getImage(image) { data in
            self.lessonImage.image = UIImage(data: data)
        }
        lessonTitle.text = post.title
        lessonLocationPrice.text = "(\(post.content2 ?? "-")) \(post.price.formatted())원"
        starLate.text = "4.8 (후기 \(post.comments.count)개)"
    }
    
}
