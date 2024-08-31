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
        let postId: BehaviorSubject<String>             /// 상세 화면 진입 시 전달되는 post id
        let bookmarkButtonTap: ControlEvent<Void>       /// 북마크 버튼 탭
        let reservationButtonTap: ControlEvent<Void>    /// 레슨 신청 버튼 탭
        let infoControlTap: ControlProperty<Int>        /// 레슨상세정보-레슨후기 Segmented Control
        let teacherProfileTap: ControlEvent<Void>       /// 선생님 프로필 이미지 탭
        let commentText: ControlProperty<String?>       /// 후기 댓글 텍스트
        let commentButtonTap: ControlEvent<Void>        /// 후기 등록 버튼 탭
    }
    
    struct Output {
        let detailInfo: PublishSubject<Post>
        let infoControlTap: BehaviorSubject<Int>
        let userID: PublishSubject<String>
        let isBookmark: PublishSubject<Bool>
        let isReservation: PublishSubject<Bool>
        let commentDone: PublishSubject<Bool>
    }
    
    func transform(input: Input) -> Output {
        let detailInfo = PublishSubject<Post>()
        let infoControlTap = BehaviorSubject(value: 0)
        let userID = PublishSubject<String>()
        let isBookmark = PublishSubject<Bool>()
        let isReservation = PublishSubject<Bool>()
        let commentResult = PublishSubject<Bool>()
        
        /// 레슨 정보 상세 조회
        input.postId
            .flatMap { postId in
                NetworkManager.shared.apiCall(api: .post(.getPostsDetail(id: postId)), of: Post.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    detailInfo.onNext(value)
                    let myID = UserDefaultsManager.userId
                    isReservation.onNext(value.likes.contains(myID))
                    isBookmark.onNext(value.likes2.contains(myID))
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
                let body = ReservationBookmarkBody(like_status: !isBookmark)
                return NetworkManager.shared.apiCall(api: .post(.postBookmark(id: post.post_id, body: body)), of: ReservationResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    isBookmark.onNext(value.like_status)
                case .failure(let error):
                    print("북마크/취소 실패")
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 북마크 버튼 눌렀을 때 상세 정보 업데이트 (북마크 한 사람 리스트업용)
        isBookmark
            .withLatestFrom(input.postId)
            .flatMap { postId in
                return NetworkManager.shared.apiCall(api: .post(.getPostsDetail(id: postId)), of: Post.self)
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
                    isReservation.onNext(value.like_status)
                case .failure(let error):
                    print("레슨 신청/취소 실패")
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    
        /// 레슨 신청 버튼 눌렀을 때 상세 정보 업데이트 (레슨 신청/취소한 사람 리스트업용)
        isReservation
            .withLatestFrom(input.postId)
            .flatMap { postId in
                return NetworkManager.shared.apiCall(api: .post(.getPostsDetail(id: postId)), of: Post.self)
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
        
        /// 레슨 상세 정보 / 선생님 정보 컨트롤 탭
        input.infoControlTap
            .bind { idx in
                print("컨트롤 선택: ", idx)
                infoControlTap.onNext(idx)
            }
            .disposed(by: disposeBag)
        
        /// 선생님 프로필 이미지 탭 (선생님 프로필 조회)
        input.teacherProfileTap
            .withLatestFrom(detailInfo)
            .map { post in
                return post.creator.user_id
            }
            .bind { id in
                userID.onNext(id)
            }
            .disposed(by: disposeBag)
        
        let dataForPostComment = Observable.combineLatest(input.postId, input.commentText.orEmpty)
            .map { (podyId, commentText) in
                return (podyId, "\(commentText)")
            }
        
        /// 레슨 후기 등록 버튼 탭
        input.commentButtonTap
            .withLatestFrom(dataForPostComment)
            .flatMap { (postId, commentText) in
                let body = PostCommentBody(content: commentText)
                return NetworkManager.shared.apiCall(api: .post(.postComment(id: postId, body: body)), of: CommentResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("후기 등록 성공")
                    commentResult.onNext(true)
                case .failure(let error):
                    print("후기 등록 실패")
                    commentResult.onNext(false)
                }
            }
            .disposed(by: disposeBag)
        
        // let dataForGetComment = Observable.combineLatest(input.postId, commentResult)
        //     .map { (postId, result) in
        //         return (postId, result)
        //     }
        
        /// 레슨 후기 등록 성공 여부에 따라 댓글 데이터 업데이트
        commentResult
            .withLatestFrom(input.postId)
            .flatMap { postId in
                return NetworkManager.shared.apiCall(api: .post(.getPostsDetail(id: postId)), of: Post.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    detailInfo.onNext(value)
                    let myID = UserDefaultsManager.userId
                    isReservation.onNext(value.likes.contains(myID))
                    isBookmark.onNext(value.likes2.contains(myID))
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(detailInfo: detailInfo,
                      infoControlTap: infoControlTap, 
                      userID: userID,
                      isBookmark: isBookmark,
                      isReservation: isReservation,
                      commentDone: commentResult)
    }
    
}
