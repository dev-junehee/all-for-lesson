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
    
    static let shared = NetworkManager()
    private init() { }
    
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
    
    /// 액세스 토큰 갱신
    func refreshToken() {
        let api = Router.accessToken(accessToken: UserDefaultsManager.accessToken, 
                                     refreshToken:  UserDefaultsManager.refreshToken)
       
        AF.request(api.endPoint,
                   encoding: JSONEncoding.default,
                   headers: api.headers)
            .responseDecodable(of: RefreshTokenResponse.self) { response in
                if response.response?.statusCode == 418 {
                    // RootViewController를 로그인 화면으로 변경
                    NavigationManager.shared.changeRootViewControllerToLogin()
                    // 필요시 UserDefaults 제거
                    UserDefaultsManager.deleteAllUserDefaults()
                } else {
                    switch response.result {
                    case .success(let value):
                        UserDefaultsManager.accessToken = value.accessToken // 성공했을 때 AccessToken 교체
                    case .failure(let error):
                        print("리프레시 토큰 갱신 오류", error)
                        return
                    }
                }
            }
    }
    
}
