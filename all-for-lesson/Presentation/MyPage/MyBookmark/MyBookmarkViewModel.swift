//
//  MyBookmarkViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyBookmarkViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearTrigger: Observable<[Any]>
        let bookmarkTap: ControlEvent<Post>
    }
    
    struct Output {
        let bookmarkList: PublishSubject<[Post]>
        let bookmarkTap: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let bookmarkList = PublishSubject<[Post]>()
        let postID = PublishSubject<String>()
        
        /// 화면 진입 시 내가 수강한 레슨 내역 불러오기
        input.viewWillAppearTrigger
            .flatMapLatest { _ in
                return NetworkManager.shared.apiCall(api: .post(.getBookmark), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("북마크 내역 불러오기 성공")
                    bookmarkList.onNext(value.data)
                case .failure(let error):
                    print("북마크 내역 불러오기 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 레슨 내역 선택 시 상세 화면 연결
        input.bookmarkTap
            .map { $0.post_id }
            .bind(to: postID)
            .disposed(by: disposeBag)
        
        return Output(bookmarkList: bookmarkList,
                      bookmarkTap: postID)
    }
    
}
