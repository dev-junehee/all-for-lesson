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
    
    func callUserRequest<T: Decodable>(api: UserRouter, of type: T.Type) -> Single<Result<T, Error>> {
        let encoding: ParameterEncoding = api.method == .get ? URLEncoding.default : JSONEncoding.default
        return Single.create { observer -> Disposable in
            AF.request(api.endPoint,
                       method: api.method,
                       parameters: api.params,
                       encoding: encoding,
                       headers: api.headers)
                // .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    if response.response?.statusCode == 419 {
                        print("액세스 토큰 갱신 필요")
                        self.refreshToken()
                    } else {
                        switch response.result {
                        case .success(let value):
                            observer(.success(.success(value)))
                        case .failure(let error):
                            observer(.success(.failure(error)))
                        }
                    }
                }
            return Disposables.create()
        }.debug("API 네트워크 통신 >>>")
    }
    
    /// 액세스 토큰 갱신
    func refreshToken() {
        print("토큰 갱신 시작")
        let api = Router.accessToken
       
        AF.request(api.endPoint,
                   encoding: JSONEncoding.default,
                   headers: api.headers)
            .responseDecodable(of: RefreshTokenResponse.self) { response in
                if response.response?.statusCode == 418 {
                    print("418 리프레시 토큰 갱신 필요 - 재로그인")
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
