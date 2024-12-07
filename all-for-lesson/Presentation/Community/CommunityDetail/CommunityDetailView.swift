//
//  CommunityDetailView.swift
//  all-for-lesson
//
//  Created by junehee on 10/20/24.
//

import UIKit
import SnapKit
import Then

final class CommunityDetailView: BaseView {
    
    private lazy var scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
    
    private lazy var container = UIView().then {
        $0.addSubview(titleLabel)
        $0.addSubview(profileImage)
        $0.addSubview(nameLabel)
        $0.addSubview(createDateLabel)
        $0.addSubview(contentLabel)
        $0.addSubview(commentImage)
        $0.addSubview(commentLabel)
        $0.addSubview(commentCountLabel)
        $0.addSubview(separateLine)
        $0.addSubview(collectionView)
    }
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = Resource.Font.bold18
    }
    
    private let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 20
        $0.backgroundColor = Resource.Color.paleGray
        $0.image = .person
        $0.contentMode = .scaleAspectFit
    }
    
    private let nameLabel = UILabel().then {
        $0.font = Resource.Font.bold14
        $0.textColor = Resource.Color.fontBlack
    }
    
    private let createDateLabel = UILabel().then {
        $0.font = Resource.Font.regular12
        $0.textColor = Resource.Color.darkGray
    }
    
    private let contentLabel = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.numberOfLines = 0
    }
    
    private let commentImage = UIImageView().then {
        $0.image = .commentDark
    }
    
    private let commentLabel = UILabel().then {
        $0.text = "댓글"
        $0.textColor = Resource.Color.darkGray
        $0.font = Resource.Font.bold16
    }
    
    private let commentCountLabel = UILabel().then {
        $0.textAlignment = .right
        $0.textColor = Resource.Color.darkGray
        $0.font = Resource.Font.bold14
    }
    
    private let separateLine = UILabel().then {
        $0.backgroundColor = Resource.Color.paleGray
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(CommunityCommentCollectionViewCell.self, forCellWithReuseIdentifier: CommunityCommentCollectionViewCell.id)
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: width / 5)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func setHierarchyLayout() {
        self.addSubview(scrollView)
        scrollView.addSubview(container)
        
        let safeArea = self.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView.snp.width)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(container).offset(8)
            $0.horizontalEdges.equalTo(container).inset(16)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.equalTo(container).inset(16)
            $0.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalTo(container).inset(16)
        }
        
        createDateLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalTo(container).inset(16)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(container).inset(16)
        }
        
        commentImage.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.leading.equalTo(container).offset(16)
            $0.size.equalTo(24)
        }

        commentLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentImage)
            $0.leading.equalTo(commentImage.snp.trailing).offset(6)
            $0.width.equalTo(100)
            $0.height.equalTo(20)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentImage)
            $0.leading.equalTo(commentLabel.snp.trailing)
            $0.trailing.equalTo(container).inset(16)
            $0.height.equalTo(20)
        }
        
        separateLine.snp.makeConstraints {
            $0.top.equalTo(commentImage.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(container)
            $0.height.equalTo(10)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom)
            $0.horizontalEdges.equalTo(container)
            $0.height.equalTo(300)
            $0.bottom.equalTo(container.snp.bottom)
        }
    }
    
    func updateCommunityDetailView(post: Post) {
        titleLabel.text = post.title
        nameLabel.text = post.creator.nick
        if let createAt = post.createAt {
            createDateLabel.text = "\(createAt.getFormattedDateString()) 게시됨"
        } else {
            createDateLabel.text = "\(Date().getFormattedDateString()) 게시됨"
        }
        contentLabel.text = post.content
        commentCountLabel.text = "\(post.comments.count)"
        
        titleLabel.sizeToFit()
        contentLabel.sizeToFit()
    }
}
