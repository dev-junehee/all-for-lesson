//
//  HashTagViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import Foundation
import RxCocoa
import RxSwift

final class HashTagViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearTrigger: Observable<[Any]>
        let searchText: ControlProperty<String?>
        let searchButtonTap: ControlEvent<Void>
        let hashtagButtonTap: ControlEvent<String>
    }
    
    struct Output {
        let recommendHashtagList: BehaviorSubject<[String]>
        let searchHashtagList: PublishSubject<[Post]>
    }
    
    func transform(input: Input) -> Output {
        let recommend = Constant.HashTag.recommend
        var shuffled = Array(recommend.shuffled().prefix(16))
        
        let recommendHashtagList = BehaviorSubject<[String]>(value: recommend)
        let searchHashtagList = PublishSubject<[Post]>()
        
        /// 화면 처음 로드 시 추천 검색어 바인딩
        input.viewWillAppearTrigger
            .bind { _ in
                shuffled = shuffled.shuffled()
                recommendHashtagList.onNext(shuffled)
            }
            .disposed(by: disposeBag)
                
        /// 해시태그 검색어 입력 때마다 관련어로 추천 해시태그 데이터 변경
        input.searchText.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { return "\($0)" }
            .bind { searchText in
                if searchText == "" {
                    recommendHashtagList.onNext(shuffled)
                } else {
                    let filtered = recommend.filter { $0.contains(searchText) }
                    if filtered.count == 0 {
                        let shuffled = Array(recommend.shuffled().prefix(16))
                        recommendHashtagList.onNext(shuffled)
                    } else {
                        recommendHashtagList.onNext(filtered)
                    }
                }
            }
            .disposed(by: disposeBag)

        /// 검색 버튼 클릭 시 필드에 있는 값으로 검색
        input.searchButtonTap
            .throttle(.seconds(3), scheduler: MainScheduler.instance)
            .withLatestFrom(input.searchText.orEmpty)
            .flatMap { searchText in
                let query = HashTagQuery(
                    next: "",
                    limit: "99999",
                    product_id: ProductId.defaultId,
                    hashTag: searchText)
                return NetworkManager.shared.apiCall(api: .post(.getHashTag(query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("버튼 탭 - 해시태그 검색 성공")
                    print(value)
                    searchHashtagList.onNext(value.data)
                case .failure(let error):
                    print("버튼 탭 - 해시태그 검색 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 해시태그 버튼 클릭 시 해당 키워드로 검색
        input.hashtagButtonTap
            .flatMap { hashtag in
                let query = HashTagQuery(
                    next: "",
                    limit: "99999",
                    product_id: ProductId.defaultId,
                    hashTag: hashtag)
                return NetworkManager.shared.apiCall(api: .post(.getHashTag(query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("추천 검색어 해시태그 성공")
                    print(value)
                    searchHashtagList.onNext(value.data)
                case .failure(let error):
                    print("추천 검색어 해시태그 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(recommendHashtagList: recommendHashtagList, 
                      searchHashtagList: searchHashtagList)
    }
    
}
