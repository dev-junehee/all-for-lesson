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
        $0.text = "비전공자를 예고 출신처럼! 이론부터 실기까지 음대 입시 총집합 Set"
    }
    
    private let starImage = UIImageView().then {
        $0.image = Resource.SystemImage.star
        $0.tintColor = Resource.Color.yellow
    }
    
    private let starLate = UILabel().then {
        $0.font = Resource.Font.regular14
        $0.text = "4.8 (후기 211개)"
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
    private let lessonDetailInfoView = UIView().then {
        $0.backgroundColor = .orange
        $0.isHidden = false
    }
    
    private let teacherDetailInfoView = UIView().then {
        $0.backgroundColor = .yellow
        $0.isHidden = true
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
            $0.height.equalTo(1000)
        }
        
        lessonDetailInfoView.snp.makeConstraints {
            $0.edges.equalTo(detailInfoBox)
        }
        
        teacherDetailInfoView.snp.makeConstraints {
            $0.edges.equalTo(detailInfoBox)
        }
        
    }
    
    func updateLessonDetailInfo() {
        
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
