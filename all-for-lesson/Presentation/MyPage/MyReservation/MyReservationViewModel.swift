//
//  MyReservationViewModel.swift
//  all-for-lesson
//
//  Created by junehee on 8/29/24.
//

import Foundation
import RxCocoa
import RxSwift

final class MyReservationViewModel: InputOutput {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let viewWillAppearTrigger: Observable<[Any]>
        let reservationTap: ControlEvent<String>
    }
    
    struct Output {
        let reservationList: PublishSubject<[PayValidationResponse]>
        let reservationTap: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        let reservationList = PublishSubject<[PayValidationResponse]>()
        let postID = PublishSubject<String>()
        
        /// 화면 진입 시 내가 수강한 레슨 내역 불러오기
        // input.viewWillAppearTrigger
        //     .flatMapLatest { _ in
        //         return NetworkManager.shared.apiCall(api: .post(.getReservatioin), of: PostResponse.self)
        //     }
        //     .bind { result in
        //         switch result {
        //         case .success(let value):
        //             print("수강 내역 불러오기 성공")
        //             reservationList.onNext(value.data)
        //         case .failure(let error):
        //             print("수강 내역 불러오기 실패", error)
        //         }
        //     }
        //     .disposed(by: disposeBag)
        
        let myPaymentsResponse = PublishSubject<MyPaymentsResponse>()
        
        input.viewWillAppearTrigger
            .flatMapLatest { _ in
                NetworkManager.shared.apiCall(api: .pay(.getMyPayments), of: MyPaymentsResponse.self)
            }
            .bind { result in
                switch result {
                case .success(let value):
                    print("나의 결제 내역 불러오기 성공")
                    reservationList.onNext(value.data ?? [])
                case .failure(let error):
                    print("나의 결제 내역 불러오기 실패", error)
                }
            }
            .disposed(by: disposeBag)

        /// 레슨 내역 선택 시 상세 화면 연결
        input.reservationTap
            // .map { $0.post_id }
            .bind(to: postID)
            .disposed(by: disposeBag)
        
        return Output(reservationList: reservationList, 
                      reservationTap: postID)
    }
    
}
