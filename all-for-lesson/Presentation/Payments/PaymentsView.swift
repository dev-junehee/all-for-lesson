//
//  PaymentsView.swift
//  all-for-lesson
//
//  Created by junehee on 9/1/24.
//

import UIKit
import WebKit
import SnapKit
import Then

final class PaymentsView: BaseView {
    
    let payWebView = WKWebView().then {
        $0.backgroundColor = .clear
    }
    
    override func setHierarchyLayout() {
        self.addSubview(payWebView)
        
        payWebView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
