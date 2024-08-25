//
//  LessonOpenView.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import UIKit
import PhotosUI
import SnapKit
import Then

/// title (레슨 제목)
/// price (레슨 가격)
/// content (레슨 소개)
/// content 1 (레슨 과목-전공)
/// content 2 (레슨 위치-서울, 경기...)
/// content 3 (레슨 타입 - 취미, 입시)
/// content 4 (인기/흥미)
/// content 5
/// product_id
/// files

final class LessonOpenView: BaseView {

    /// 제목
    private let titleLabel = UILabel().then {
        $0.text = "레슨 제목"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    let titleField = UITextField().then {
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    /// 가격
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
        $0.keyboardType = .numberPad
    }
    
    /// 과목
    private let majorLabelFront = UILabel().then {
        $0.text = "레슨 과목"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    lazy var majorField = UITextField().then {
        $0.placeholder = "선택"
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.textAlignment = .center
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.inputView = majorPicker
        setToolBar(to: $0)
    }
    
    private let majorLabelBack = UILabel().then {
        $0.text = "을(를) 가르쳐요."
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.regular12
    }
    
    let majorPicker = UIPickerView()
    
    /// 위치
    private let locationLabelFront = UILabel().then {
        $0.text = "레슨 위치"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    lazy var locationField = UITextField().then {
        $0.placeholder = "선택"
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.textAlignment = .center
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.inputView = locationPicker
        setToolBar(to: $0)
    }
    
    private let locationLabelBack = UILabel().then {
        $0.text = "에서 진행해요."
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.regular12
    }
    
    let locationPicker = UIPickerView()
    
    /// 타입
    private let typeLabelFront = UILabel().then {
        $0.text = "레슨 타입"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    lazy var typeField = UITextField().then {
        $0.placeholder = "선택"
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.textAlignment = .center
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.tintColor = .clear
        $0.inputView = typePicker
        setToolBar(to: $0)
    }
    
    private let typeLabelBack = UILabel().then {
        $0.text = "대상이에요."
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.regular12
    }
    
    let typePicker = UIPickerView()
    
    /// 소개
    private let contentLabel = UILabel().then {
        $0.text = "레슨 소개"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    let contentField = UITextView().then {
        $0.font = Resource.Font.regular14
        $0.textColor = Resource.Color.fontBlack
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
    }
    
    /// 사진
    let fileLabel = UILabel().then {
        $0.text = "파일 업로드"
        $0.textColor = Resource.Color.fontBlack
        $0.font = Resource.Font.bold16
    }
    
    let photoButton = UIButton().then {
        var config = UIButton.Configuration.filled()
        var title = AttributedString("사진 선택")
        title.font = Resource.Font.regular14
        config.attributedTitle = title
        config.cornerStyle = .small
        config.baseBackgroundColor = Resource.Color.lightGray
        config.baseForegroundColor = Resource.Color.fontBlack
        $0.configuration = config
    }
    
    lazy var photoStack = UIStackView().then {
        $0.addArrangedSubview(firstPhoto)
        $0.addArrangedSubview(secondPhoto)
        $0.addArrangedSubview(thirdPhoto)
        $0.axis = .horizontal
        $0.distribution = .fillEqually
        $0.spacing = 10
    }
    
    let firstPhoto = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
    }
    
    let secondPhoto = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
    }
    
    let thirdPhoto = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
    }
    
    private let photoConfig = {
        var config = PHPickerConfiguration()
        config.selectionLimit = 3
        config.filter = .any(of: [.images])
        return config
    }()
    
    lazy var photoPicker = PHPickerViewController(configuration: photoConfig)
    
    override func setHierarchyLayout() {
        [
            titleLabel, titleField, priceLabel, priceField,
            majorLabelFront, majorField, majorLabelBack,
            locationLabelFront, locationField, locationLabelBack,
            typeLabelFront, typeField, typeLabelBack,
            contentLabel, contentField,
            fileLabel, photoButton, photoStack
            
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
        majorLabelFront.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        majorField.snp.makeConstraints {
            $0.centerY.equalTo(majorLabelFront)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        majorLabelBack.snp.makeConstraints {
            $0.top.equalTo(priceField.snp.bottom).offset(16)
            $0.leading.equalTo(majorField.snp.trailing).offset(8)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(20)
        }
        
        /// 레슨 위치
        locationLabelFront.snp.makeConstraints {
            $0.top.equalTo(majorField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        locationField.snp.makeConstraints {
            $0.centerY.equalTo(locationLabelFront)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        locationLabelBack.snp.makeConstraints {
            $0.top.equalTo(majorField.snp.bottom).offset(16)
            $0.leading.equalTo(locationField.snp.trailing).offset(8)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(20)
        }
        
        /// 레슨 타입
        typeLabelFront.snp.makeConstraints {
            $0.top.equalTo(locationField.snp.bottom).offset(16)
            $0.leading.equalTo(safeArea).inset(16)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        typeField.snp.makeConstraints {
            $0.centerY.equalTo(typeLabelFront)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(80)
            $0.height.equalTo(30)
        }
        
        typeLabelBack.snp.makeConstraints {
            $0.top.equalTo(locationField.snp.bottom).offset(16)
            $0.leading.equalTo(typeField.snp.trailing).offset(8)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(20)
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
        
        photoButton.snp.makeConstraints {
            $0.top.equalTo(fileLabel)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(80)
            $0.height.equalTo(20)
        }
        
        photoStack.snp.makeConstraints {
            $0.top.equalTo(photoButton.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalTo(safeArea).inset(16)
            $0.height.equalTo(90)
        }
        
        firstPhoto.snp.makeConstraints {
            $0.verticalEdges.equalTo(photoStack)
        }
        
        secondPhoto.snp.makeConstraints {
            $0.verticalEdges.equalTo(photoStack)
        }
        
        thirdPhoto.snp.makeConstraints {
            $0.verticalEdges.equalTo(photoStack)
        }
        
    }
    
    private func setToolBar(to pickerField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let select = UIBarButtonItem(title: "선택")
        let blank = UIBarButtonItem(systemItem: .flexibleSpace)
        toolBar.setItems([blank, select], animated: true)
        toolBar.isUserInteractionEnabled = true
        pickerField.inputAccessoryView = toolBar
    }
    
    
}
