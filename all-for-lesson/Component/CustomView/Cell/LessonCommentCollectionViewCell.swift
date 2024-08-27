//
//  LessonCommentCollectionViewCell.swift
//  all-for-lesson
//
//  Created by junehee on 8/28/24.
//

import UIKit
import SnapKit
import Then

final class LessonCommentCollectionViewCell: BaseCollectionViewCell {
    
    private let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.backgroundColor = Resource.Color.paleGray
    }
 
    private lazy var labelStack = UIStackView().then {
        $0.addArrangedSubview(nickLabel)
        $0.addArrangedSubview(commentLabel)
        $0.axis = .vertical
    }
    
    private let nickLabel = UILabel().then {
        $0.font = Resource.Font.bold14
        // $0.backgroundColor = .red
    }
    
    private let commentLabel = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.numberOfLines = 0
        // $0.backgroundColor = .orange
        $0.isUserInteractionEnabled = false
    }
    
    override func setHierarchyLayout() {
        [profileImage, labelStack].forEach { self.addSubview($0) }
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalTo(self)
            $0.size.equalTo(60)
        }
        
        labelStack.snp.makeConstraints {
            $0.top.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(8)
            $0.width.equalTo(250)
            $0.bottom.equalToSuperview()
        }
        
        nickLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(labelStack)
            $0.height.equalTo(20)
        }
        
        commentLabel.snp.makeConstraints {
            $0.top.equalTo(nickLabel.snp.bottom)
            $0.horizontalEdges.equalTo(labelStack)
            $0.bottom.equalTo(labelStack)
        }
    }
    
    func updateCell(comment: CommentResponse) {
        let creator = comment.creator
        nickLabel.text = creator.nick
        commentLabel.text = comment.content
    }
    
}
