//
//  LessonDetailViewController.swift
//  all-for-lesson
//
//  Created by junehee on 8/20/24.
//

import UIKit
import WebKit
import iamport_ios
import RxCocoa
import RxSwift
import SnapKit

final class LessonDetailViewController: BaseViewController {
    
    private let detailView = LessonDetailView()
    
    // private lazy var webView = WKWebView().then {
    //     $0.backgroundColor = UIColor.clear
    //     $0.isHidden = true
    // }
    // 
    
    private let viewModel = LessonDetailViewModel()
    private let disposeBag = DisposeBag()
    
    let postId = BehaviorSubject<String>(value: "")
    // let postValidation = PublishSubject<PayValidationBody>()
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func setViewController() {
        setBackBarButton(Resource.Color.whiteSmoke)
        setImgBarButton(image: Resource.Image.bookmarkFill, color: Resource.Color.whiteSmoke, action: nil, type: .right)
        toggleTabBar(isShow: false)
        
        // view.addSubview(webView)
        // webView.snp.makeConstraints {
        //     $0.edges.equalToSuperview()
        // }
    }
    
    private func bind() {
        guard let bookmarkButton = navigationItem.rightBarButtonItem else { return }
        
        let input = LessonDetailViewModel.Input(
            postId: postId,
            bookmarkButtonTap: bookmarkButton.rx.tap,
            reservationButtonTap: detailView.reservationButton.rx.tap,
            infoControlTap: detailView.lessonInfoControl.rx.selectedSegmentIndex,
            teacherProfileTap: detailView.lessonDetailInfoView.teacherProfileImage.rx.tap,
            commentText: detailView.commentFieldView.commentField.rx.text,
            commentButtonTap: detailView.commentFieldView.commentButton.rx.tap)
        let output = viewModel.transform(input: input)
        
        /// 레슨 상세 데이터 바인딩
        output.detailInfo
            .bind(with: self) { owner, detailInfo in
                owner.detailView.updateLessonDetailInfo(detailInfo)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 후기 데이터 바인딩
        output.detailInfo
            .map { post in
                return post.comments
            }
            .bind(to: detailView.lessonCommentView.collectionView.rx.items(cellIdentifier: LessonCommentCollectionViewCell.id, cellType: LessonCommentCollectionViewCell.self)) { item, element, cell in
                print(element)
                cell.updateCell(comment: element)
            }
            .disposed(by: disposeBag)
        
        /// 북마크 결과
        output.isBookmark
            .bind(with: self) { owner, isBookmark in
                print("북마크 상태", isBookmark)
                if isBookmark {
                    owner.navigationItem.rightBarButtonItem?.tintColor = Resource.Color.purple
                } else {
                    owner.navigationItem.rightBarButtonItem?.tintColor = Resource.Color.white
                }
            }
            .disposed(by: disposeBag)
        
        output.reservationButtonTap
            .bind(with: self) { owner, post in
                let paymentsVC = PaymentsViewController()
                paymentsVC.postData = post
                // paymentsVC.payWebView.isHidden = false
                // owner.present(paymentsVC, animated: true)
                owner.navigationController?.pushViewController(paymentsVC, animated: true)
                // owner.payments(post)
            }
            .disposed(by: disposeBag)
        
        /// 레슨 신청 결과
        output.isReservation
            .bind(with: self) { owner, isReservation in
                let title = AttributedString(isReservation ? "레슨 신청 취소" : "레슨 신청하기")
                let foregroundColor = isReservation ? Resource.Color.white : Resource.Color.fontBlack
                let backgroundColor = isReservation ? Resource.Color.purple : Resource.Color.yellow
                
                var config = owner.detailView.reservationButton.configuration
                config?.attributedTitle = title
                config?.attributedTitle?.font = Resource.Font.bold16
                config?.baseBackgroundColor = backgroundColor
                config?.baseForegroundColor = foregroundColor
                owner.detailView.reservationButton.configuration = config
            }
            .disposed(by: disposeBag)
        
        /// Segmented Control
        output.infoControlTap
            .bind(with: self) { owner, selectedIndex in
                owner.detailView.updateSegmentedControl(selectedIndex)
                owner.detailView.commentFieldView.isHidden = selectedIndex == 1 ? false : true
            }
            .disposed(by: disposeBag)
        
        /// 선생님 프로필 탭 - 유저 상세 화면 전환
        output.userID
            .bind(with: self) { owner, userID in
                let userDetailVC = UserProfileViewController()
                userDetailVC.userID.onNext(userID)
                // owner.navigationController?.pushViewController(userDetailVC, animated: true)
            }
            .disposed(by: disposeBag)
        
        /// 후기 댓글 결과
        output.commentDone
            .bind(with: self) { owner, success in
                if success {
                    owner.detailView.commentFieldView.commentField.text = ""
                }
            }
            .disposed(by: disposeBag)
    }
    
    // private func payments(_ post: Post) {
    //     print("🍏 이건 실행되나?")
    //     
    //     let payment = IamportPayment(
    //         pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
    //         merchant_uid: "ios_\(API.KEY.key)_\(Int(Date().timeIntervalSince1970))",
    //         amount: "\(post.price)").then {
    //             $0.pay_method = PayMethod.card.rawValue
    //             $0.name = post.title
    //             $0.buyer_name = "김준희"   /// 주문자 이름 대신 프로젝트 내에서 본인 이름 사용
    //             $0.app_scheme = "allforlesson"
    //         }
    //     
    //     // webView.isHidden = true
    //     
    //     Iamport.shared.paymentWebView(
    //         webViewMode: webView,
    //         userCode: API.KEY.userCode,
    //         payment: payment) { iamportResponse in
    //             print("payment >>>", String(describing: iamportResponse))
    //             
    //             guard let imp_uid = iamportResponse?.imp_uid else { return }
    //             let body = PayValidationBody(imp_uid: imp_uid, post_id: post.post_id)
    //             
    //             Observable.just(body)
    //                 .flatMap { body in
    //                     NetworkManager.shared.apiCall(api: .pay(.postValidation(body: body)), of: PayValidationResponse.self)
    //                 }
    //                 .bind { result in
    //                     switch result {
    //                     case .success(let value):
    //                         print("검증 성공")
    //                         print(value)
    //                     case .failure(let error):
    //                         print("검증 실패", error)
    //                     }
    //                 }
    //                 .dispose()
    //             
    //             // self?.postValidation.onNext(body)
    //             }
    //             
    // }
    
}
