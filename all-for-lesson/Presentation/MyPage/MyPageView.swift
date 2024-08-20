//
//  MyPageView.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import UIKit
import SnapKit
import Then

final class MyPageView: BaseView {
    
    var viewType: JoinCase = .student {
        didSet {
            studentTeacherButtonToggle()
        }
    }
    
    let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 35
        $0.backgroundColor = Resource.Color.lightGray
    }
    
    private lazy var profileNameEmailStack = UIStackView().then {
        $0.addArrangedSubview(nameLabel)
        $0.addArrangedSubview(emailLabel)
        $0.axis = .vertical
    }
    
    private let nameLabel = UILabel().then {
        $0.font = Resource.Font.bold16
        $0.text = "최유진 선생님"
    }
    
    private let emailLabel = UILabel().then {
        $0.font = Resource.Font.regular12
        $0.textColor = Resource.Color.darkGray
        $0.text = "abcdefghijk@test.com"
    }
    
    private let studentButton = UserTypeButton(type: .student)
    private let teacherButton = UserTypeButton(type: .teacher)
    
    private lazy var buttonStack = UIStackView().then {
        $0.addArrangedSubview(reservationButton)
        $0.addArrangedSubview(bookmarkButton)
        $0.addArrangedSubview(friendButton)
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    private let reservationButton = MyPageMenuButton("수강 내역 확인", image: Resource.SystemImage.mypageButtons[0])
    private let bookmarkButton = MyPageMenuButton("북마크한 레슨", image: Resource.SystemImage.mypageButtons[1])
    private let friendButton = MyPageMenuButton("친구 관리", image: Resource.SystemImage.mypageButtons[2])
    
    lazy var tableView = UICollectionView(frame: .zero, collectionViewLayout: layout())
        
    private func layout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .plain)
        config.showsSeparators = true
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
    
    override func setHierarchyLayout() {
        [profileImage, profileNameEmailStack, studentButton, teacherButton, buttonStack, tableView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalTo(safeArea).offset(16)
            $0.size.equalTo(70)
        }
        
        profileNameEmailStack.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalTo(studentButton.snp.leading)
            $0.height.equalTo(30)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(profileNameEmailStack)
            $0.height.equalTo(20)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(profileNameEmailStack)
        }
        
        studentButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.trailing.equalTo(safeArea).inset(32)
        }
        
        teacherButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.trailing.equalTo(safeArea).inset(32)
        }
        
        buttonStack.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(32)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(100)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(16)
            $0.horizontalEdges.bottom.equalTo(safeArea)
        }
    }
    
    func studentTeacherButtonToggle() {
        studentButton.isHidden = !teacherButton.isHidden
        teacherButton.isHidden = !studentButton.isHidden
    }
    
}
