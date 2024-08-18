//
//  MyPageViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import SnapKit

final class MyPageViewController: BaseViewController {
    
    private let logoutButton = UIButton().then {
        $0.setTitle("(임시) 로그아웃", for: .normal)
        $0.backgroundColor = Resource.Color.purple
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MyPageViewController")
        
        view.addSubview(logoutButton)
        
        logoutButton.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(60)
            $0.center.equalToSuperview()
        }
        
        logoutButton.addTarget(self, action: #selector(userTokenCheckTest), for: .touchUpInside)
    }
    
    /// 로그아웃 + 화면 전환 확인용 임시
    @objc func userTokenCheckTest() {
        UserDefaultsManager.deleteAllUserDefaults() 
        NavigationManager.shared.changeRootViewControllerToLogin()
    }
    
}
