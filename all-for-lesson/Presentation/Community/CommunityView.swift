//
//  CommunityView.swift
//  all-for-lesson
//
//  Created by junehee on 10/19/24.
//

import UIKit
import SnapKit
import Then

final class CommunityView: BaseView {
    
    /// 상단 로고 타이틀
    private lazy var logoView = UIView().then {
        $0.addSubview(logoButton)
        $0.backgroundColor = Resource.Color.white
    }
    
    private let logoButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = Resource.Color.fontBlack
        
        var title = AttributedString("커뮤니티")
        title.font = Resource.Font.viewTitle
        config.attributedTitle = title

        /// 버튼 이미지
        config.image = .community
        config.imagePlacement = .leading
        config.imagePadding = 10
        
        $0.configuration = config
    }
    
    /// 나의 작성글 확인 영역
    private lazy var myContentView = UIView().then {
        $0.backgroundColor = Resource.Color.skyblue
        $0.addSubview(profileImage)
        $0.addSubview(nameLabel)
        $0.addSubview(contentCountLabel)
        $0.addSubview(commentCountLabel)
        $0.addSubview(createButton)
    }
    
    private let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 35
        $0.backgroundColor = Resource.Color.lightGray
        $0.image = .person
        $0.contentMode = .scaleAspectFit
    }
    
    private let nameLabel = UILabel().then {
        $0.font = Resource.Font.bold16
        $0.textColor = Resource.Color.whiteSmoke
        $0.text = "초밥조아"
    }
    
    private let contentCountLabel = UILabel().then {
        $0.font = Resource.Font.regular12
        $0.textColor = Resource.Color.whiteSmoke
        $0.text = "작성글 : 0개"
    }
    
    private let commentCountLabel = UILabel().then {
        $0.font = Resource.Font.regular12
        $0.textColor = Resource.Color.whiteSmoke
        $0.text = "작성댓글 : 0개"
    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout()).then {
        $0.register(CommunityCollectionViewCell.self, forCellWithReuseIdentifier: CommunityCollectionViewCell.id)
        $0.backgroundColor = Resource.Color.lightGray
        $0.keyboardDismissMode = .onDrag
    }
    
    private func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 180)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 0, bottom: 8, right: 0)
        layout.scrollDirection = .vertical
        return layout
    }
    
    let createButton = CommonButton(title: "글쓰기", color: Resource.Color.whiteSmoke, fontColor: .black)
    
    override func setHierarchyLayout() {
        [logoView, myContentView, collectionView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        logoView.snp.makeConstraints {
            $0.top.equalTo(self).offset(60)
            $0.horizontalEdges.equalTo(safeArea).inset(8)
            $0.height.equalTo(50)
        }
        
        myContentView.snp.makeConstraints {
            $0.top.equalTo(logoView.snp.bottom)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(120)
        }
        
        profileImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(20)
        }
        
        contentCountLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.top.equalTo(contentCountLabel.snp.bottom)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        createButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(16)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(36)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(myContentView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    func updateCommunityProfile() {
        
    }

}
