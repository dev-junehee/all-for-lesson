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
        let menuTap: ControlEvent<String>
    }
    
    struct Output {
        let profileResponse: PublishSubject<MyProfileResponse>
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
                NetworkManager.shared.callUserRequest(api: .profile, of: MyProfileResponse.self)
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
                      menuList: menuList,
                      openLesson: openLesson,
                      userLogout: userLogout)
    }
    
}
