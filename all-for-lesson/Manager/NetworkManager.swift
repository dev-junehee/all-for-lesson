//
//  NetworkManager.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import Alamofire
import RxSwift

final class NetworkManager {
    
    private init() { }
    static let shared = NetworkManager()
    
    // Single 객체로 Alamofire 통신
    func checkEmail(_ email: String) -> Single<Result<EmailResponse, Error>> {
        return Single.create { observer -> Disposable in
            
            let url = Router.email(email: email).endPoint
            print("url", url)
            print("email", email)
            
            let body: Parameters = [
                "email": email
            ]
            
            let headers: HTTPHeaders = [
                API.Header.contentType: API.Header.json,
                API.Header.sesacKey: API.KEY.key
            ]
            
            AF.request(url,
                       method: .post,
                       parameters: body,
                       headers: headers)
                // .validate(statusCode: 200...299)
                .responseDecodable(of: EmailResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(.success(value)))
                    case .failure(let error):
                        observer(.success(.failure(error)))
                    }
                }
            return Disposables.create()
        }.debug("checkEmail")
    }
    
}
