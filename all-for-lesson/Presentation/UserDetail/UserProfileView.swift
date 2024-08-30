//
//  UserDetailView.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import UIKit
import SnapKit
import Then

final class UserProfileView: BaseView {
    
    private let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 35
        $0.backgroundColor = Resource.Color.lightGray
        $0.image = .person
        $0.contentMode = .scaleAspectFit
    }
    
    private let nameLabel = UILabel().then {
        $0.font = Resource.Font.bold16
    }
    
    override func setHierarchyLayout() {
        [profileImage, nameLabel].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalTo(safeArea).offset(16)
            $0.size.equalTo(70)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(20)
        }
    }
    
    func updateUserProfile(user: UserProfileResponse) {
        nameLabel.text = user.nick
    }
    
}
