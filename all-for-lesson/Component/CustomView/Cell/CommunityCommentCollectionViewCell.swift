//
//  CommunityCommentCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 12/7/24.
//

import UIKit
import SnapKit
import Then

final class CommunityCommentCollectionViewCell: BaseCollectionViewCell {
    
    private let nickLabel = UILabel().then {
        $0.font = Resource.Font.bold14
    }
    
    private let commentLabel = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.isUserInteractionEnabled = false
        $0.numberOfLines = 0
    }
    
    override func setHierarchyLayout() {
        [nickLabel, commentLabel].forEach { contentView.addSubview($0) }
        
        nickLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.horizontalEdges.equalTo(contentView)
            $0.height.equalTo(20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom)
            $0.leading.equalTo(contentView)
            $0.trailing.equalTo(contentView).inset(16)
            $0.bottom.equalTo(contentView)
        }
    }
    
    func updateCell(comment: CommentResponse) {
        let creator = comment.creator
        nickLabel.text = creator.nick
        commentLabel.text = comment.content
    }
}

