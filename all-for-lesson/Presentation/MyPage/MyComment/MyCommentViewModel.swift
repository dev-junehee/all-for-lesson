//
//  MyCommentViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyCommentViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearTrigger: Observable<[Any]>
    }
    
    struct Output {
        let commentList: PublishSubject<[CommentResponse]>
    }
    
    func transform(input: Input) -> Output {
        let commentList = PublishSubject<[CommentResponse]>()
        
        /// 화면 로드 시 데이터 바인딩
        input.viewWillAppearTrigger
            .flatMap { _ in
                let myID = UserDefaultsManager.userId
                let query = PostQuery(next: "", limit: "", product_id: ProductId.defaultId)
                return NetworkManager.shared.apiCall(api: .post(.getUserPosts(id: myID, query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    var comments: [CommentResponse] = []
                    for post in value.data {
                        comments.append(contentsOf: post.comments)
                    }
                    // value.data.map {
                    //     comments.append(contentsOf: $0.comments)
                    // }
                    commentList.onNext(comments)
                case .failure(let error):
                    print("레슨 수강 후기 불러오기 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(commentList: commentList)
    }
    
    
}
