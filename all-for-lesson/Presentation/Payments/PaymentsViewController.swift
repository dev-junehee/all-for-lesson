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
    
    // lazy var payment = IamportPayment(
    //     pg: PG.html5_inicis.makePgRawName(pgId: "INIpayTest"),
    //     merchant_uid: "ios_\(API.KEY.key)_\(Int(Date().timeIntervalSince1970))",
    //     amount: "\(postData?.price ?? 1000)").then {
    //         $0.pay_method = PayMethod.card.rawValue
    //         $0.name = postData?.title ?? "allforlesson"
    //         $0.buyer_name = UserDefaultsManager.nick   /// 주문자 이름 대신 프로젝트 내에서 본인 이름 사용
    //         $0.app_scheme = "allforlesson"
    //     }
    
    lazy var payWebView = WKWebView(frame: view.bounds)
    
    override func setViewController() {
        view.addSubview(payWebView)
        
        payWebView.backgroundColor = UIColor.clear
            
        // payWebView.snp.makeConstraints {
        //     $0.edges.equalTo(view.safeAreaLayoutGuide)
        // }
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
        
        print("11111111111111111111111111111111111111111111")
        
        Iamport.shared.paymentWebView(
            webViewMode: payWebView,
            userCode: API.KEY.userCode,
            payment: payment) { iamportResponse in
                print(">>>>>>>>>======= 이거나오나?!!!!!?!?!?!?!?!?")
                
                print("payment >>>", String(describing: iamportResponse))
                // 
                // guard let imp_uid = iamportResponse?.imp_uid else { return }
                // let body = PayValidationBody(imp_uid: imp_uid, post_id: post.post_id)
                // 
                // Observable.just(body)
                //     .flatMap { body in
                //         NetworkManager.shared.apiCall(api: .pay(.postValidation(body: body)), of: PayValidationResponse.self)
                //     }
                //     .bind { result in
                //         switch result {
                //         case .success(let value):
                //             print("검증 성공")
                //             print(value)
                //         case .failure(let error):
                //             print("검증 실패", error)
                //         }
                //     }
                //     .dispose()
                
                // self?.postValidation.onNext(body)
            }
    }
    
}
