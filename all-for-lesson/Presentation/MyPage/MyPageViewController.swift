//
//  MyPageViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import UIKit
import RxCocoa
import RxSwift

final class MyPageViewController: BaseViewController {
        
    private let mypageView = MyPageView()
    private let viewModel = MyPageViewModel()
    private let disposeBag = DisposeBag()
    
    private var viewDidLoadTrigger = PublishSubject<Void>()
    
    override func loadView() {
        view = mypageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        viewDidLoadTrigger.onNext(())
    }
    
    override func setViewController() {
        navigationItem.title = "마이페이지"
        setImgBarButton(image: Resource.SystemImage.gear, target: self, action: #selector(settingButtonClicked), type: .right)
    }
    
    private func bind() {
        // let viewWillAppearTrigger = self.rx.methodInvoked(#selector(self.viewDidLoad))
        
        let input = MyPageViewModel.Input(viewDidLoadTrigger: viewDidLoadTrigger,
                                          menuTap: mypageView.tableView.rx.modelSelected(String.self))
        let output = viewModel.transform(input: input)
        
        
        output.profileResponse
            .bind(with: self) { owner, profileData in
                owner.mypageView.updateProfile(profileData)
            }
            .disposed(by: disposeBag)
        
        output.menuList
            .bind(to: mypageView.tableView.rx.items(cellIdentifier: "MenuCell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.textLabel?.text = element
                cell.accessoryType = .disclosureIndicator
                cell.textLabel?.font = Resource.Font.regular14
            }
            .disposed(by: disposeBag)
        
        /// 레슨 개설하기 탭 - 화면 전환
        output.openLesson
            .bind(with: self) { owner, _ in
                owner.present(LessonOpenViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 로그아웃 탭 - UserDefaults 데이터 삭제 후 로그인 화면 전환
        output.userLogout
            .bind(with: self) { owner, _ in
                NavigationManager.shared.changeRootViewControllerToLogin()
            }
            .disposed(by: disposeBag)
        
    }
    
    /// 설정 바버튼 클릭 (임시)
    @objc func settingButtonClicked() {
        
    }
    
}
