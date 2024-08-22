//
//  LessonOpenView.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import UIKit
import SnapKit
import Then

/// title (레슨 제목)
/// price (레슨 가격)
/// content (레슨 소개)
/// content 1 (레슨 과목-전공)
/// content 2 (레슨 타입-전공/취미 선택)
/// content 3 (레슨 위치-서울, 경기, 인천... 선택)
/// content 4
/// content 5
/// product_id
/// files

final class LessonOpenView: BaseView {

    // MARK: 제목
    private let titleLabel = UILabel().then {
        $0.text = "레슨 제목"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    let titleField = UITextField().then {
        $0.textColor = Resource.Color.fontBlack
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    // MARK: 가격
    private let priceLabel = UILabel().then {
        $0.text = "레슨 가격"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    let priceField = UITextField().then {
        $0.textColor = Resource.Color.fontBlack
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    // MARK: 과목
    private let majorLabel = UILabel().then {
        $0.text = "레슨 과목"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    lazy var majorField = UITextField().then {
        $0.placeholder = "선택"
        $0.textColor = Resource.Color.fontBlack
        $0.textAlignment = .center
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.inputView = majorPicker
        setToolBar(to: $0)
    }
    
    let majorPicker = UIPickerView()
    
    // MARK: 위치
    private let locationLabel = UILabel().then {
        $0.text = "레슨 위치"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    lazy var locationField = UITextField().then {
        $0.placeholder = "선택"
        $0.textColor = Resource.Color.fontBlack
        $0.textAlignment = .center
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.inputView = locationPicker
    }
    
    let locationPicker = UIPickerView()
    
    // MARK: 타입
    private let typeLabel = UILabel().then {
        $0.text = "레슨 타입"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    lazy var typeField = UITextField().then {
        $0.placeholder = "선택"
        $0.textColor = Resource.Color.fontBlack
        $0.textAlignment = .center
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.inputView = typePicker
    }
    
    let typePicker = UIPickerView()
    
    // MARK: 소개
    private let contentLabel = UILabel().then {
        $0.text = "레슨 소개"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    let contentField = UITextField().then {
        $0.textColor = Resource.Color.fontBlack
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    // MARK: 파일
    private let fileLabel = UILabel().then {
        $0.text = "파일 업로드"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }

    
    override func setHierarchyLayout() {
        [
            titleLabel, titleField, priceLabel, priceField,
            majorLabel, majorField, locationLabel, locationField,
            typeLabel, typeField, contentLabel, contentField,
            fileLabel
            
        ].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        /// 레슨 제목
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(32)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        titleField.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(34)
        }
        
        /// 레슨 가격
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(titleField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        priceField.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(34)
        }
        
        /// 레슨 과목
        majorLabel.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        majorField.snp.makeConstraints {
            $0.centerY.equalTo(majorLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            // $0.trailing.equalTo(safeArea).inset(16)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        /// 레슨 위치
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(majorField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        locationField.snp.makeConstraints {
            $0.centerY.equalTo(locationLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            // $0.trailing.equalTo(safeArea).inset(16)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        /// 레슨 타입
        typeLabel.snp.makeConstraints {
            $0.top.equalTo(locationField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        typeField.snp.makeConstraints {
            $0.centerY.equalTo(typeLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            // $0.trailing.equalTo(safeArea).inset(16)
            $0.width.equalTo(70)
            $0.height.equalTo(30)
        }
        
        /// 레슨 소개
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(typeField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        contentField.snp.makeConstraints {
            $0.top.equalTo(contentLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(300)
        }
        
        /// 파일
        fileLabel.snp.makeConstraints {
            $0.top.equalTo(contentField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
    }
    
    private func setToolBar(to pickerField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let cancel = UIBarButtonItem(title: "취소")
        let select = UIBarButtonItem(title: "선택")
        let blank = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.setItems([cancel, blank, select], animated: true)
        toolBar.isUserInteractionEnabled = true
        pickerField.inputAccessoryView = toolBar
    }
    
}
