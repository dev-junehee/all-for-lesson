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
        let communityCellTap: ControlEvent<Post>
    }
    
    struct Output {
        let profileData:  PublishSubject<MyProfileResponse>
        let communityList: PublishSubject<[Post]>
        let postButtonTap: ControlEvent<Void>
        let communityID: PublishSubject<String>
    }
    
    func transform(input: Input) -> Output {
        let profileData = PublishSubject<MyProfileResponse>()
        let communityList = PublishSubject<[Post]>()
        let communityID = PublishSubject<String>()
        
        /// 화면 진입 시 개인정보 로드
        input.viewDidLoadTrigger
            .flatMapLatest { _ in
                NetworkManager.shared.apiCall(api: .user(.getMyProfile), of: MyProfileResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    profileData.onNext(value)
                case .failure(let error):
                    print("커뮤니티 탭 개인정보 불러오기 실패: ", error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 화면 진입 시 커뮤니티 데이터 로드
        input.viewDidLoadTrigger
            .flatMapLatest { _ in
                let query = PostQuery(next: "", limit: "99999999", product_id: ProductId.community)
                return NetworkManager.shared.apiCall(api: .post(.getPosts(query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    communityList.onNext(value.data)
                case .failure(let error):
                    print("커뮤니티 게시글 불러오기 실패: ", error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 커뮤니티 게시물 선택
        input.communityCellTap
            .bind { post in
                print("testtesttest")
                communityID.onNext(post.post_id)
            }
            .disposed(by: disposeBag)
            
        
        return Output(profileData: profileData,
                      communityList: communityList,
                      postButtonTap: input.postButtonTap,
                      communityID: communityID)
    }
    
}
