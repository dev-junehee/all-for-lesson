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
    
    private let messageButton = CommonButton(title: Constant.Lesson.dm, 
                                             color: Resource.Color.paleGray,
                                             fontColor: .black)
    
    lazy var reservationButton = CommonButton(title: Constant.Lesson.reservationLesson,
                                              color: Resource.Color.yellow,
                                              fontColor: .black)
    
    let lessonInfoControl = UISegmentedControl(items: Constant.Lesson.detailView).then {
        $0.selectedSegmentIndex = 0
        $0.isUserInteractionEnabled = true
    }
    
    /// 레슨 상세 정보 + 레슨 후기 컨트롤 컨테이너
    private lazy var detailInfoBox = UIView().then {
        $0.addSubview(lessonDetailInfoView)
        $0.addSubview(lessonCommentView)
    }
    
    /// 레슨 상세 정보
    let lessonDetailInfoView = LessonDetailInfoView().then {
        $0.isHidden = false
    }

    /// 레슨 후기
    let lessonCommentView = LessonCommentView().then {
        $0.isHidden = true
        $0.backgroundColor = .yellow
    }
    
    // 댓글창
    let commentFieldView = LessonCommentFieldView().then {
        $0.backgroundColor = Resource.Color.white
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 0.5
        $0.isHidden = true
    }
    
    override func setHierarchyLayout() {
        [backgroundImage, scrollView, commentFieldView].forEach { self.addSubview($0) }
        
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
            $0.height.equalTo(500)   /// 추후 수치 수정하기!
        }
        
        /// 레슨 상세 정보 컨테이너 (선생님+레슨상세)
        lessonDetailInfoView.snp.makeConstraints {
            $0.edges.equalTo(detailInfoBox)
        }
        
        /// 레슨 후기
        lessonCommentView.snp.makeConstraints {
            $0.edges.equalTo(detailInfoBox)
        }
        
        commentFieldView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(self)
            $0.height.equalTo(100)
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
        
        lessonDetailInfoView.lessonContent.text = post.content
        
        updateTeacherDetailInfo(post: post)
    }
    
    func updateTeacherDetailInfo(post: Post) {
        let teacher = post.creator
        lessonDetailInfoView.teacherName.text = "\(teacher.nick) 선생님"
        lessonDetailInfoView.teacherMajor.text = "대표 전공 : \(post.content1 ?? "-")"
        lessonDetailInfoView.teacherLocation.text = "레슨 위치 : \(post.content2 ?? "-")"
    }
    
    func updateSegmentedControl(_ selectedIndex: Int) {
        lessonInfoControl.selectedSegmentIndex = selectedIndex
        detailInfoViewToggle(selectedIndex)
    }
    
    func detailInfoViewToggle(_ selectedIndex: Int) {
        if selectedIndex == 0 {
            lessonDetailInfoView.isHidden = false
            lessonCommentView.isHidden = true
        } else {
            lessonDetailInfoView.isHidden = true
            lessonCommentView.isHidden = false
        }
    }
    
}
