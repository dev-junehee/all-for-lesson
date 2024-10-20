//
//  CommunityCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class CommunityCollectionViewCell: BaseCollectionViewCell {

    private let titleLabel = UILabel().then {
        $0.font = Resource.Font.bold16
        // $0.backgroundColor = .red
    }
    
    private let contentLabel = UITextView().then {
        $0.font = Resource.Font.regular14
        // $0.backgroundColor = .orange
        $0.isScrollEnabled = false
        $0.isEditable = false
    }
    
    private let commentImage = UIImageView().then {
        $0.image = .comment
        // $0.backgroundColor = .blue
    }
    
    private let commentCountLabel = UILabel().then {
        $0.font = Resource.Font.bold16
        $0.textColor = Resource.Color.lightGray
        // $0.backgroundColor = .brown
    }
    
    override func setHierarchyLayout() {
        contentView.backgroundColor = Resource.Color.white
        [titleLabel, contentLabel, commentImage, commentCountLabel].forEach { contentView.addSubview($0) }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.height.equalTo(20)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalTo(contentView).inset(16)
            $0.height.equalTo(100)
        }
        
        commentImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(4)
            $0.leading.equalTo(contentView).offset(16)
            $0.size.equalTo(24)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(4)
            $0.leading.equalTo(commentImage.snp.trailing).offset(4)
            $0.trailing.equalTo(contentView)
            $0.height.equalTo(24)
        }
    }
    
    func updateCell(post: Post) {
        titleLabel.text = post.title
        contentLabel.text = post.content
        // commentCountLabel.text = post.comments.count.formatted()
        commentCountLabel.text = Int.random(in: 0...50).formatted()
    }
    
}
