//
//  LessonCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit
import SnapKit
import Then

final class LessonCollectionViewCell: BaseCollectionViewCell {
    
    let lessonImage = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 12
        $0.backgroundColor = Resource.Color.paleGray
    }
    
    let lessonTitle = UILabel().then {
        $0.font = Resource.Font.bold14
        $0.numberOfLines = 0
    }
    
    private let starImage = UIImageView().then {
        $0.image = Resource.Image.star
        $0.tintColor = Resource.Color.yellow
    }
    
    let starLate = UILabel().then {
        $0.font = Resource.Font.regular12
    }
    
    let lessonPrice = UILabel().then {
        $0.font = Resource.Font.medium14
    }
    
    let bookmarkButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = Resource.Image.bookmark
        $0.tintColor = Resource.Color.lightGray
        $0.configuration = config
    }
    
    override func setHierarchyLayout() {
        [lessonImage, lessonTitle, starImage, starLate, lessonPrice, bookmarkButton].forEach { contentView.addSubview($0) }
        
        lessonImage.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
            $0.width.equalTo(160)
            $0.height.equalTo(100)
        }
        
        lessonTitle.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.equalTo(lessonImage.snp.trailing).offset(8)
            $0.trailing.equalTo(contentView).inset(16)
            $0.height.equalTo(40)
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(lessonTitle.snp.bottom).offset(4)
            $0.leading.equalTo(lessonImage.snp.trailing).offset(8)
            $0.size.equalTo(16)
        }
        
        starLate.snp.makeConstraints {
            $0.top.equalTo(lessonTitle.snp.bottom).offset(4)
            $0.leading.equalTo(starImage.snp.trailing)
            $0.width.equalTo(100)
            $0.height.equalTo(16)
        }
        
        lessonPrice.snp.makeConstraints {
            $0.bottom.equalTo(contentView).inset(24)
            $0.leading.equalTo(lessonImage.snp.trailing).offset(8)
            $0.width.equalTo(100)
            $0.height.equalTo(16)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(contentView).inset(16)
            $0.size.equalTo(30)
        }
    }
    
    func updateCell(post: Post, isTeacher: Bool = false) {
        guard let image = post.files.first else { return }
        NetworkManager.shared.getImage(image) { data in
            self.lessonImage.image = UIImage(data: data)
        }
        lessonTitle.text = post.title
        starLate.text = "4.8 (후기 \(post.comments.count)개)"
        lessonPrice.text = "\(post.price.formatted())원"
        
        /// 내가 북마크한 경우 / 아닌 경우
        if post.likes2.contains(UserDefaultsManager.userId) {
            bookmarkButton.setImage(Resource.Image.bookmarkFill, for: .normal)
            bookmarkButton.tintColor = Resource.Color.skyblue
        } else {
            bookmarkButton.setImage(Resource.Image.bookmark, for: .normal)
            bookmarkButton.tintColor = Resource.Color.lightGray
        }
        /// 선생님일 경우 북마크 제외
        bookmarkButton.isHidden = isTeacher
    }
    
}
