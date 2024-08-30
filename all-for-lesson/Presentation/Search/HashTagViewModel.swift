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
    }
    
    struct Output {
        let recommendHashtagList: PublishSubject<[String]>
    }
    
    func transform(input: Input) -> Output {
        let recommendHashtagList = PublishSubject<[String]>()
        
        /// 화면 처음 로드 시 추천 검색어 바인딩
        input.viewWillAppearTrigger
            .bind { _ in
                let recommend = Array(Constant.HashTag.recommend.shuffled().prefix(16))
                recommendHashtagList.onNext(recommend)
            }
            .disposed(by: disposeBag)
        
        /// 해시태그 검색어 입력 때마다 1초 뒤 검색
        // input.searchText.orEmpty
        //     .debounce(.seconds(2), scheduler: MainScheduler.instance)
        //     .flatMap { searchText in
        //         let query = HashTagQuery(
        //             next: "",
        //             limit: "",
        //             product_id: ProductId.defaultId,
        //             hashTag: searchText)
        //         return NetworkManager.shared.apiCall(api: .post(.getHashTag(query: query)), of: PostResponse.self)
        //     }
        //     .bind { result in
        //         switch result {
        //         case .success(let value):
        //             print("해시태그 검색 성공")
        //             print(value)
        //         case .failure(let error):
        //             print("해시태그 검색 실패", error)
        //         }
        //     }
        //     .disposed(by: disposeBag)
        
        /// 검색 버튼 클릭 시 필드에 있는 값으로 검색
        input.searchButtonTap
            .withLatestFrom(input.searchText.orEmpty)
            .flatMap { searchText in
                let query = HashTagQuery(
                    next: "",
                    limit: "",
                    product_id: ProductId.defaultId,
                    hashTag: searchText)
                return NetworkManager.shared.apiCall(api: .post(.getHashTag(query: query)), of: PostResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("버튼 탭 - 해시태그 검색 성공")
                    print(value)
                case .failure(let error):
                    print("버튼 탭 - 해시태그 검색 실패", error)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(recommendHashtagList: recommendHashtagList)
    }
    
}
