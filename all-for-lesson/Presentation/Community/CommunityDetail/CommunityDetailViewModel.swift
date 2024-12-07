//
//  CommunityDetailViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 10/26/24.
//

import Foundation
import RxCocoa
import RxSwift

final class CommunityDetailViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let postId: BehaviorSubject<String>             /// 상세 화면 진입 시 전달되는 post id
    }
    
    struct Output {
        let communityDetail: PublishSubject<Post>
    }
    
    func transform(input: Input) -> Output {
        let communityDetail = PublishSubject<Post>()
        
        // 커뮤니티 정보 상세 조회
        input.postId
            .flatMap { postId in
                NetworkManager.shared.apiCall(api: .post(.getPostsDetail(id: postId)), of: Post.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    communityDetail.onNext(value)
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        
        return Output(communityDetail: communityDetail)
    }
    
}
