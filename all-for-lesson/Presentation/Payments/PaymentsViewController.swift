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
    
    var postData: Post?
    
    lazy var payWebView = WKWebView(frame: view.bounds)
    
    override func setViewController() {
        view.addSubview(payWebView)
        payWebView.backgroundColor = UIColor.clear
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        payments()
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
            payment: payment) { iamportResponse in
                print("payment >>>", String(describing: iamportResponse))
            }
    }
    
}
