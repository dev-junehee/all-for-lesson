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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        toggleTabBar()
    }
    
    override func setViewController() {
        navigationItem.title = "마이페이지"
        setImgBarButton(image: Resource.Image.gear, action: nil, type: .right)
    }
    
    private func bind() {
        let input = MyPageViewModel.Input(
            viewDidLoadTrigger: viewDidLoadTrigger,
            reservationButtonTap: mypageView.reservationButton.rx.tap,
            bookmarkButtonTap: mypageView.bookmarkButton.rx.tap,
            lessonButtonTap: mypageView.lessonButton.rx.tap,
            commentButtonTap: mypageView.commentButton.rx.tap,
            menuTap: mypageView.tableView.rx.modelSelected(String.self))
        let output = viewModel.transform(input: input)
        
        
        output.profileResponse
            .bind(with: self) { owner, profileData in
                owner.mypageView.updateProfile(profileData)
            }
            .disposed(by: disposeBag)
        
        /// 수강 내역 버튼 탭 (수강생)
        output.reservationButtonTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(MyReservationController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 북마크한 레슨 버튼 탭 (수강생)
        output.bookmarkButtonTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(MyBookmarkViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 관리 버튼 탭 (선생님)
        output.lessonButtonTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(MyLessonViewController(), animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 후기 버튼 탭 (선생님)
        output.commentButtonTap
            .bind(with: self) { owner, _ in
                owner.navigationController?.pushViewController(MyCommentViewController(), animated: true)
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
                let lessonOpenVC = UINavigationController(rootViewController: LessonOpenViewController())
                owner.present(lessonOpenVC, animated: true)
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
