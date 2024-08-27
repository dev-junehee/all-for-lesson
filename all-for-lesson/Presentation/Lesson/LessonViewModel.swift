//
//  LessonViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import Foundation
import RxCocoa
import RxSwift

final class LessonViewModel: InputOutput {
    
    private let disposeBag =  DisposeBag()
    
    struct Input {
        let menuType: BehaviorSubject<HomeMenuCase?>
        let lessonTap: ControlEvent<Post>
    }
    
    struct Output {
        let lessonViewTitle: Observable<(Int, String)>
        let lessonList: PublishSubject<[Post]>
    }
    
    func transform(input: Input) -> Output {
        let lessonViewTitle = BehaviorSubject(value: (0, ""))
        let lessonList = PublishSubject<[Post]>()
        
        /// 레슨 검색 대상 (menuType) - 타이틀 텍스트 수정
        input.menuType
            .compactMap { menuCase in
                return menuCase?.rawValue
            }
            .bind { idx in
                print("idx", idx)
                let titleText = Constant.Home.menu[idx]
                lessonViewTitle.onNext((idx, titleText))
            }
            .disposed(by: disposeBag)
        
        /// 레슨 검색
        input.menuType
            .compactMap { menuCase in
                return menuCase
            }
            .flatMap { menuCase in
                let query = PostQuery(next: "", limit: "", product_id: ProductId.defaultId)
                return NetworkManager.shared.apiCall(api: .post(.getPosts(query: query)), of: PostResponse.self).map { result in
                    return (menuCase, result)
                }
            }
            .bind { (menuCase: HomeMenuCase, result: Result<PostResponse, NetworkErrorCase>) in
                switch result {
                case .success(let value):
                    var majorList: [String] = []
                    
                    switch menuCase {
                    case .all:
                        lessonList.onNext(value.data)
                        return
                    case .string:
                        majorList = ["바이올린", "비올라", "첼로", "콘트라베이스"]
                    case .woodwind:
                        majorList = ["플룻", "오보에", "클라리넷", "바순"]
                    case .brass:
                        majorList = ["트럼펫", "트롬본", "튜바", "호른", "색소폰"]
                    case .piano:
                        majorList = ["피아노"]
                    case .vocal:
                        majorList = ["성악"]
                    case .composition:
                        majorList = ["클래식 작곡"]
                    case .etc:
                        majorList = ["타악기", "하프"]
                    }
                    
                    /// (전체보기 제외) 각 전공 리스트에 맞는 레슨 필터링
                    lessonList.onNext(value.data.filter { post in
                        if let content1 = post.content1 {
                            return majorList.contains(where: { content1.contains($0) })
                        }
                        return false
                    })
                case .failure(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
        
        /// 레슨 검색 결과 탭
        input.lessonTap
            .bind { postData in
                print(postData)
            }
            .disposed(by: disposeBag)
        
        return Output(lessonViewTitle: lessonViewTitle,
                      lessonList: lessonList)
    }
    

    
}
