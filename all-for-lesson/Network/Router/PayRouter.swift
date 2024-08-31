//
//  PayRouter.swift
//  all-for-lesson
//
//  Created by junehee on 8/31/24.
//

import Foundation
import Alamofire

/**
 `postValidation` 결제 영수증 검증
 `getMyPayments` 결제 내역 리스트
 */

enum PayRouter {
    case postValidation(body: PayValidationBody)
    case getMyPayments
}

extension PayRouter: TargetType {
   
    var base: String {
        API.URL.base
    }
    
    var path: String {
        switch self {
        case .postValidation:  API.URL.payValidation
        case .getMyPayments: API.URL.payMe
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .postValidation: .post
        case .getMyPayments: .get
        }
    }
    
    var header: [String : String] {
        switch self {
        case .postValidation, .getMyPayments:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.contentType: API.Header.json,
                API.Header.sesacKey: API.KEY.key
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .postValidation(let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
        case .getMyPayments:
            return nil
        }
    }
    
    var query: [URLQueryItem]? {
        return nil
    }
    
}
