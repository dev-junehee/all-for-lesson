//
//  MyPageViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyPageViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoadTrigger: Observable<Void>
        let reservationButtonTap: ControlEvent<Void>    /// 수강생 - 수강 내역 버튼
        let bookmarkButtonTap: ControlEvent<Void>       /// 수강생 - 북마크 내역 버튼
        let lessonButtonTap: ControlEvent<Void>         /// 선생님 - 나의 레슨 관리 버튼
        let commentButtonTap: ControlEvent<Void>        /// 선생님 - 레슨 수강 후기 버튼
        let menuTap: ControlEvent<String>
    }
    
    struct Output {
        let profileResponse: PublishSubject<MyProfileResponse>
        let reservationButtonTap: ControlEvent<Void>
        let bookmarkButtonTap: ControlEvent<Void>
        let lessonButtonTap: ControlEvent<Void>
        let commentButtonTap: ControlEvent<Void>
        let menuList: PublishSubject<[String]>
        let openLesson: Observable<Void>
        let userLogout: Observable<Void>
    }
    
    func transform(input: Input) -> Output {
        let profileResponse = PublishSubject<MyProfileResponse>()
        let menuList = PublishSubject<[String]>()
        let openLesson = PublishSubject<Void>()
        let userLogout = PublishSubject<Void>()
        
        /// 마이페이지 로딩 > 자기 정보 조회 > 수강생/선생님 여부에 따라 화면 로딩
        input.viewDidLoadTrigger
            .flatMap { _ in
                NetworkManager.shared.apiCall(api: .user(.getMyProfile), of: MyProfileResponse.self)
            }
            .bind(with: self) { owner, result in
                switch result {
                case .success(let response):
                    print(response)
                    profileResponse.onNext(response)
                    if response.phoneNum == "0" {
                        menuList.onNext(Constant.MyPage.Menu.student)
                    } else {
                        menuList.onNext(Constant.MyPage.Menu.teacher)
                    }
                case .failure(let error):
                    print(error)
                }
                
            }
            .disposed(by: disposeBag)
            
        
        /// 메뉴 테이블뷰 탭
        input.menuTap
            .bind(with: self) { owner, title in
                switch title {
                case "레슨 개설하기":
                    print(title)
                    openLesson.onNext(())
                case "로그아웃":
                    print(title)
                    UserDefaultsManager.deleteAllUserDefaults()  /// 저장된 값 모두 삭제 후 로그인으로 화면 전환
                    userLogout.onNext(())
                case "회원탈퇴":
                    print(title)
                default:
                    return
                }
            }
            .disposed(by: disposeBag)
    
        return Output(profileResponse: profileResponse, 
                      reservationButtonTap: input.reservationButtonTap,
                      bookmarkButtonTap: input.bookmarkButtonTap,
                      lessonButtonTap: input.lessonButtonTap,
                      commentButtonTap: input.commentButtonTap,
                      menuList: menuList,
                      openLesson: openLesson,
                      userLogout: userLogout)
    }
    
}
