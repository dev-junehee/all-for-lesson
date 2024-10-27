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
        $0.addSubview(container)
    }
    
    private lazy var container = UIView().then {
        $0.addSubview(titleLabel)
        $0.addSubview(profileImage)
        $0.addSubview(nameLabel)
        $0.addSubview(createDateLabel)
        $0.addSubview(contentLabel)
        $0.addSubview(separateLine)
        $0.addSubview(commentImage)
        $0.addSubview(commentLabel)
        $0.addSubview(commentCountLabel)
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "(입시생) 실기 선생님은 어떻게 찾나요ㅠㅠ?"
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
        $0.text = "초밥조아"
    }
    
    private let createDateLabel = UILabel().then {
        $0.font = Resource.Font.regular12
        $0.textColor = Resource.Color.darkGray
        $0.text = "2024. 08. 15 게시됨"
    }
    
    private let contentLabel = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.numberOfLines = 0
        $0.text = "도저히 답이 없어서 질문드립니다... ㅠㅠ 현재 실기에 많은 시간을 꾸준히 투자하지만 실력이 오르지 않습니다... 실기 연습 시간을 늘려서라도 어캐든 90점 이상 받고 싶지만 가면갈수록 잘 되던 부분도 손이 굳고...오래걸리고...틀립니다... 혹시 실기 연습 어떻게 해야하는지... 실력을 올리고 싶은데... 어떤 강사분을 추천하는지 질문드립니다..."
    }
    
    private let separateLine = UILabel().then {
        $0.backgroundColor = Resource.Color.paleGray
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
        $0.text = "123개"
        $0.textAlignment = .right
        $0.textColor = Resource.Color.darkGray
        $0.font = Resource.Font.bold14
    }
    
    override func setHierarchyLayout() {
        self.addSubview(scrollView)
        let safeArea = self.safeAreaLayoutGuide
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(safeArea)
        }
        
        container.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
            // $0.bottom.equalTo(interestingCollectionView.snp.bottom).offset(16)
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
        
        separateLine.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(container)
            $0.height.equalTo(1)
        }
        
        commentImage.snp.makeConstraints {
            $0.top.equalTo(separateLine.snp.bottom).offset(20)
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
        
    }
    
    func updateCommunityDetailView() {
        titleLabel.sizeToFit()
        contentLabel.sizeToFit()
    }
    
}
