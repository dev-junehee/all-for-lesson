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
    
    var viewType: JoinCase = .student
    
    let profileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 35
        $0.backgroundColor = Resource.Color.lightGray
        $0.image = .person
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var profileNameEmailStack = UIStackView().then {
        $0.addArrangedSubview(nameLabel)
        $0.addArrangedSubview(emailLabel)
        $0.axis = .vertical
    }
    
    private let nameLabel = UILabel().then {
        $0.font = Resource.Font.bold16
    }
    
    private let emailLabel = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.darkGray
    }
    
    private let studentButton = UserTypeButton(type: .student).then {
        $0.isHidden = true
    }
    
    private let teacherButton = UserTypeButton(type: .teacher).then {
        $0.isHidden = true
    }
    
    private lazy var buttonStack = UIStackView().then {
        $0.addArrangedSubview(reservationButton)
        $0.addArrangedSubview(bookmarkButton)
        $0.addArrangedSubview(lessonButton)
        $0.addArrangedSubview(commentButton)
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 20
    }
    
    /// 수강생 버튼
    let reservationButton = MyPageMenuButton(Constant.MyPage.reservation,
                                             image: Resource.Image.mypageStudentButton[0])
    let bookmarkButton = MyPageMenuButton(Constant.MyPage.bookmark,
                                          image: Resource.Image.mypageStudentButton[1])
    
    /// 선생님 버튼
    let lessonButton = MyPageMenuButton(Constant.MyPage.myLesson, image: Resource.Image.mypageTeacherButton[0])
    let commentButton = MyPageMenuButton(Constant.MyPage.myLessonComment, image: Resource.Image.mypageTeacherButton[1])
    
    let tableView = UITableView().then {
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "MenuCell")
    }
    
    private let versionLabel = UILabel().then {
        $0.text = "All For Lesson\nv.1.0.0"
        $0.textAlignment = .center
        $0.textColor = Resource.Color.lightGray
        $0.numberOfLines = 0
        $0.font = Resource.Font.regular12
    }
    
    override func setHierarchyLayout() {
        [
            profileImage, profileNameEmailStack, studentButton, 
            teacherButton, buttonStack, tableView, versionLabel
        ].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        profileImage.snp.makeConstraints {
            $0.top.leading.equalTo(safeArea).offset(16)
            $0.size.equalTo(70)
        }
        
        profileNameEmailStack.snp.makeConstraints {
            $0.centerY.equalTo(profileImage)
            $0.leading.equalTo(profileImage.snp.trailing).offset(16)
            $0.trailing.equalTo(studentButton.snp.leading)
            $0.height.equalTo(36)
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
            $0.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(buttonStack.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalTo(versionLabel.snp.top)
        }
        
        versionLabel.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeArea)
            $0.height.equalTo(60)
        }
    }
    
    func updateProfile(_ data: MyProfileResponse) {
        nameLabel.text = data.nick
        emailLabel.text = data.email
        studentTeacherButtonToggle(userType: data.phoneNum)
    }
    
    func studentTeacherButtonToggle(userType: String) {
        if userType == "0" {  /// 수강생일 때
            studentButton.isHidden = false
            teacherButton.isHidden = true
            reservationButton.isHidden = false
            bookmarkButton.isHidden = false
            lessonButton.isHidden = true
            commentButton.isHidden = true
        } else {  /// 선생님일 때
            studentButton.isHidden = true
            teacherButton.isHidden = false
            reservationButton.isHidden = true
            bookmarkButton.isHidden = true
            lessonButton.isHidden = false
            commentButton.isHidden = false
        }
    }
    
}
