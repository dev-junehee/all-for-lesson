//
//  LessonDetailViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonDetailViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let postId: BehaviorSubject<String>
        let bookmarkButtonTap: ControlEvent<Void>
        let reservationButtonTap: ControlEvent<Void>
        let infoControlTap: ControlProperty<Int>
    }
    
    struct Output {
        let detailInfo: PublishSubject<Post>
        let infoControlTap: BehaviorSubject<Int>
    }
    
    func transform(input: Input) -> Output {
        let detailInfo = PublishSubject<Post>()
        let infoControlTap = BehaviorSubject(value: 0)
        
        /// 레슨 정보 상세 조회
        input.postId
            .flatMap { postId in
                NetworkManager.shared.apiCall(api: .post(.getPostsDetail(id: postId)), of: Post.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    detailInfo.onNext(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 북마크 버튼 탭
        input.bookmarkButtonTap
            .withLatestFrom(detailInfo)
            .flatMap{ post in
                let myID = UserDefaultsManager.userId
                let isBookmark = post.likes2.contains(myID)
                print("isBookmark >>>", isBookmark)
                let body = ReservationBookmarkBody(like_status: !isBookmark)
                print("body >>>", body)
                return NetworkManager.shared.apiCall(api: .post(.postBookmark(id: post.post_id, body: body)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("북마크 성공")
                    print(value)
                case .failure(let error):
                    print("북마크 실패")
                    print(error)
                }
            }
            .disposed(by: disposeBag)
            
        
        /// 레슨 신청 버튼 탭
        input.reservationButtonTap
            .withLatestFrom(detailInfo)
            .flatMap { post in
                let myID = UserDefaultsManager.userId
                let isReservation = post.likes.contains(myID)
                let body = ReservationBookmarkBody(like_status: !isReservation)
                return NetworkManager.shared.apiCall(api: .post(.postReservation(id: post.post_id, body: body)), of: ReservationResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("레슨 신청 성공")
                    print(value)
                case .failure(let error):
                    print("레슨 신청 실패")
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 레슨 상세 정보 / 선생님 정보 컨트롤 탭
        input.infoControlTap
            .bind { idx in
                print("컨트롤 선택: ", idx)
                infoControlTap.onNext(idx)
            }
            .disposed(by: disposeBag)
        
        
        
        return Output(detailInfo: detailInfo,
                      infoControlTap: infoControlTap)
    }
    
    
    
}
