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
            
            let URL = API.URL.base + API.URL.email
            
            let body: Parameters = [
                "email": email
            ]
            
            let headers: HTTPHeaders = [
                API.Header.contentType: API.Header.json,
                API.Header.sesacKey: API.KEY.key
            ]
            
            AF.request(URL,
                       method: .post,
                       parameters: body,
                       encoding: JSONEncoding.default,
                       headers: headers)
                .validate(statusCode: 200...299)
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
    
    
    func callRequest<T: Decodable>(api: Router, of type: T.Type) -> Single<Result<T, Error>> {
        return Single.create { observer -> Disposable in
            AF.request(api.endPoint,
                       method: api.method,
                       parameters: api.params,
                       encoding: JSONEncoding.default,
                       headers: api.headers)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        observer(.success(.success(value)))
                    case .failure(let error):
                        observer(.success(.failure(error)))
                    }
                }
            return Disposables.create()
        }.debug("API 네트워크 통신 >>>")
    }
    
}
