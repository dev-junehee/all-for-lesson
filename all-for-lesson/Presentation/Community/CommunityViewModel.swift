//
//  CommunityViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 10/19/24.
//

import Foundation
import RxCocoa
import RxSwift

final class CommunityViewModel: ViewModelType {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewDidLoadTrigger: PublishSubject<Void>
        let postButtonTap: ControlEvent<Void>
    }
    
    struct Output {
        let communityList: PublishSubject<[Post]>
        let postButtonTap: ControlEvent<Void>
    }
    
    func transform(input: Input) -> Output {
        let communityList = PublishSubject<[Post]>()
        
        /// 화면 진입 시 커뮤니티
        input.viewDidLoadTrigger
            .flatMapLatest { _ in
                let query = PostQuery(next: "", limit: "99999999", product_id: ProductId.community)
                return NetworkManager.shared.apiCall(api: .post(.getPosts(query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("커뮤니티 게시물 조회 성공")
                    print(result)
                    communityList.onNext(value.data)
                case .failure(let error):
                    print("커뮤니티 게시글 불러오기 실패: ", error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(communityList: communityList, 
                      postButtonTap: input.postButtonTap)
    }
    
}
