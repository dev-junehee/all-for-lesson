//
//  HashTagView.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import UIKit
import SnapKit
import Then

final class HashTagView: BaseView {
    
    private let titleLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.font = Resource.Font.regular30
        let titleString = NSMutableAttributedString(string: "#해시태그를\n검색해 보세요!")
        let nsString = titleString.string as NSString
        titleString.addAttribute(.font, value: Resource.Font.bold30 ?? .systemFont(ofSize: 30, weight: .bold), range: nsString.range(of: "#해시태그"))
        $0.attributedText = titleString
        // $0.backgroundColor = .lightGray
    }
    
    private let searchBackgroundView = UIView().then {
        $0.backgroundColor = Resource.Color.ivory
        $0.layer.borderColor = Resource.Color.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
    }
    
    let searchTextField = UITextField().then {
        $0.placeholder = "#개인레슨"
        $0.font = Resource.Font.regular16
    }
    
    let searchButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.image = .hashtag
        $0.configuration = config
    }
    
    override func setHierarchyLayout() {
        [titleLabel, searchBackgroundView, searchTextField, searchButton].forEach { self.addSubview($0) }
        
        let safeArea = self.safeAreaLayoutGuide
        
        titleLabel.snp.makeConstraints {
            // $0.top.equalTo(self).offset(100)
            $0.top.equalTo(safeArea)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(80)
        }
        
        searchBackgroundView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(safeArea).inset(16)
            $0.height.equalTo(50)
        }
        
        searchTextField.snp.makeConstraints {
            $0.centerY.equalTo(searchBackgroundView)
            $0.leading.equalTo(searchBackgroundView).inset(16)
            $0.trailing.equalTo(searchButton.snp.leading)
            $0.height.equalTo(32)
        }
        
        searchButton.snp.makeConstraints {
            // $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.centerY.equalTo(searchBackgroundView)
            $0.trailing.equalTo(searchBackgroundView).inset(16)
            $0.size.equalTo(32)
        }
    }
    
}
