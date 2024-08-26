//
//  LessonDetailView.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import UIKit
import SnapKit
import Then

final class LessonDetailView: BaseView {
    
    private let backgroundImage = UIImageView().then {
        $0.backgroundColor = Resource.Color.darkGray
        $0.contentMode = .scaleAspectFill
    }
    
    private lazy var scrollView = UIScrollView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.showsVerticalScrollIndicator = false
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.backgroundColor = Resource.Color.white
        $0.addSubview(container)
    }
    
    private lazy var container = UIView().then {
        $0.addSubview(lessonTitle)
        $0.addSubview(lessonPrice)
        $0.addSubview(starImage)
        $0.addSubview(starLate)
        $0.addSubview(messageButton)
        $0.addSubview(reservationButton)
        $0.addSubview(lessonInfoControl)
        $0.addSubview(detailInfoBox)
    }
    
    private let lessonTitle = UILabel().then {
        $0.font = Resource.Font.bold18
        $0.numberOfLines = 0
    }
    
    private let lessonPrice = UILabel().then {
        $0.font = Resource.Font.bold18
        $0.textAlignment = .right
    }
    
    private let starImage = UIImageView().then {
        $0.image = Resource.Image.star
        $0.tintColor = Resource.Color.yellow
    }
    
    private let starLate = UILabel().then {
        $0.font = Resource.Font.regular14
    }
    
    private let messageButton = CommonButton(title: "1:1 문의", color: Resource.Color.paleGray, fontColor: .black)
    let reservationButton = CommonButton(title: "레슨 신청하기", color: Resource.Color.yellow, fontColor: .black)
    
    let lessonInfoControl = UISegmentedControl(items: ["레슨 상세 정보", "선생님 정보"]).then {
        $0.selectedSegmentIndex = 0
        $0.isUserInteractionEnabled = true
    }
    
    private lazy var detailInfoBox = UIView().then {
        $0.addSubview(lessonDetailInfoView)
        $0.addSubview(teacherDetailInfoView)
    }
    
    /// 레슨 상세 정보
    private lazy var lessonDetailInfoView = UIView().then {
        $0.addSubview(lessonContent)
        $0.isHidden = false
    }
    
    private let lessonContent = UITextView().then {
        $0.font = Resource.Font.regular14
        $0.isUserInteractionEnabled = false
    }
    
    /// 선생님 정보
    private lazy var teacherDetailInfoView = UIView().then {
        $0.addSubview(teacherProfileImage)
        $0.addSubview(teacherContent)
        $0.isHidden = true
    }
    
    private let teacherProfileImage = UIImageView().then {
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 35
        $0.backgroundColor = Resource.Color.lightGray
    }
    
    private lazy var teacherContent = UIStackView().then {
        $0.addArrangedSubview(teacherName)
        $0.backgroundColor = .yellow
    }
    
    private let teacherName = UILabel().then {
        $0.font = Resource.Font.bold16
    }

    
    override func setHierarchyLayout() {
        [backgroundImage, scrollView].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        backgroundImage.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.horizontalEdges.equalTo(safeArea)
            $0.height.equalTo(350)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(backgroundImage.snp.bottom).inset(32)
            $0.horizontalEdges.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
        
        container.snp.makeConstraints {
            $0.top.equalTo(scrollView).offset(16)
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.width.equalToSuperview()
            $0.bottom.equalTo(detailInfoBox.snp.bottom).offset(16)
        }
        
        lessonTitle.snp.makeConstraints {
            $0.top.equalTo(container).offset(8)
            $0.horizontalEdges.equalTo(container).inset(16)
            $0.height.equalTo(50)
        }
        
        starImage.snp.makeConstraints {
            $0.top.equalTo(lessonTitle.snp.bottom).offset(16)
            $0.leading.equalTo(container).offset(16)
            $0.size.equalTo(20)
        }
        
        starLate.snp.makeConstraints {
            $0.top.equalTo(lessonTitle.snp.bottom).offset(16)
            $0.leading.equalTo(starImage.snp.trailing).offset(4)
            $0.width.equalTo(150)
            $0.height.equalTo(20)
        }
        
        lessonPrice.snp.makeConstraints {
            $0.top.equalTo(lessonTitle.snp.bottom).offset(16)
            $0.leading.equalTo(starLate.snp.trailing).offset(4)
            $0.trailing.equalTo(container).inset(16)
            $0.height.equalTo(20)
        }
        
        messageButton.snp.makeConstraints {
            $0.top.equalTo(starLate.snp.bottom).offset(16)
            $0.leading.equalTo(container).offset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(44)
        }
        
        reservationButton.snp.makeConstraints {
            $0.top.equalTo(starLate.snp.bottom).offset(16)
            $0.leading.equalTo(messageButton.snp.trailing).offset(16)
            $0.trailing.equalTo(container).inset(16)
            $0.height.equalTo(44)
        }
        
        lessonInfoControl.snp.makeConstraints {
            $0.top.equalTo(reservationButton.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(container).inset(16)
            $0.height.equalTo(40)
        }
        
        detailInfoBox.snp.makeConstraints {
            $0.top.equalTo(lessonInfoControl.snp.bottom).offset(16)
            $0.horizontalEdges.equalTo(container).inset(16)
            $0.height.equalTo(1000)   /// 추후 수치 수정하기!
        }
        
        lessonDetailInfoView.snp.makeConstraints {
            $0.edges.equalTo(detailInfoBox)
        }
        
        lessonContent.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        teacherDetailInfoView.snp.makeConstraints {
            $0.edges.equalTo(detailInfoBox)
        }
        
        teacherProfileImage.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.size.equalTo(70)
        }
        
        teacherContent.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalTo(teacherProfileImage.snp.trailing).offset(16)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(70)
        }
        
    }
    
    func updateLessonDetailInfo(_ post: Post) {
        guard let image = post.files.first else { return }
        NetworkManager.shared.getImage(image) { data in
            self.backgroundImage.image = UIImage(data: data)
        }
        lessonTitle.text = post.title
        lessonPrice.text = "\(post.price.formatted())원"
        starLate.text = "4.8 후기 \(post.comments.count)개"
        lessonContent.text = post.content
        
        updateTeacherDetailInfo(post.creator)
    }
    
    func updateTeacherDetailInfo(_ teacher: Creator) {
        teacherName.text = teacher.nick
    }
    
    func updateSegmentedControl(_ selectedIndex: Int) {
        lessonInfoControl.selectedSegmentIndex = selectedIndex
        detailInfoViewToggle(selectedIndex)
    }
    
    func detailInfoViewToggle(_ selectedIndex: Int) {
        if selectedIndex == 0 {
            lessonDetailInfoView.isHidden = false
            teacherDetailInfoView.isHidden = true
        } else {
            lessonDetailInfoView.isHidden = true
            teacherDetailInfoView.isHidden = false
        }
    }
    
}
