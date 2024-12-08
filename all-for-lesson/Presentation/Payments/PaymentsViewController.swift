//
//  PaymentsViewController.swift
//  all-for-lesson
//
//  Created by junehee on 9/1/24.
//

import UIKit
import WebKit
import iamport_ios
import RxCocoa
import RxSwift
import SnapKit

final class PaymentsViewController: BaseViewController {

    lazy var payWebView = WKWebView(frame: view.bounds)
    
    private let viewModel = PaymentsViewModel()
    
    var postData: Post?
    
    private let payBodyData = PublishSubject<PayValidationBody>()
    
    override func setViewController() {
        view.addSubview(payWebView)
        payWebView.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payments()
        bind()
    }
    
    private func payments() {
        guard let post = postData else { return }
         
        let payment = IamportPayment(
            pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
            merchant_uid: "ios_\(API.KEY.key)_\(Int(Date().timeIntervalSince1970))",
            amount: "\(post.price)").then {
                $0.pay_method = PayMethod.card.rawValue
                $0.name = post.title
                $0.buyer_name = "김준희"   /// 주문자 이름 대신 프로젝트 내에서 본인 이름 사용
                $0.app_scheme = "allforlesson"
            }
        
        Iamport.shared.paymentWebView(
            webViewMode: payWebView,
            userCode: API.KEY.userCode,
            payment: payment) { [weak self] iamportResponse in
                print("payment >>>", String(describing: iamportResponse))
                
                guard let imp_uid = iamportResponse?.imp_uid,
                      let postID = self?.postData?.post_id else { return }
                let body = PayValidationBody(imp_uid: imp_uid, post_id: postID)
                self?.payBodyData.onNext(body)
            }
    }
    
    private func bind() {
        let input = PaymentsViewModel.Input(payBodyData: payBodyData)
        let _ = viewModel.transform(input: input)
    }
    
}
