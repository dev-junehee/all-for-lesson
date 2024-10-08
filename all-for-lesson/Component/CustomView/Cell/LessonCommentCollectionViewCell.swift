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
        $0.backgroundColor = Resource.Color.lightGray
        $0.image = .person
        $0.contentMode = .scaleAspectFit
    }
 
    private lazy var labelStack = UIStackView().then {
        $0.addArrangedSubview(nickLabel)
        $0.addArrangedSubview(commentLabel)
        $0.axis = .vertical
        $0.alignment = .top
    }
    
    private let nickLabel = UILabel().then {
        $0.font = Resource.Font.bold14
    }
    
    private let commentLabel = UITextView().then {
        $0.font = Resource.Font.regular14
        $0.contentInset = .init(top: -4, left: -6, bottom: 0, right: 0)
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
            $0.trailing.equalTo(self).inset(16)
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
