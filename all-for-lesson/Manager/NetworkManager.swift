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
    
    func apiCall<T: Decodable>(api: APIRouter, of type: T.Type) -> Single<Result<T, (NetworkErrorCase)>> {
        return Single<Result<T, NetworkErrorCase>>.create { observer -> Disposable in
            do {
                let request = try api.asURLRequest()
                
                func makeRequest() {
                    AF.request(request)
                        .validate(statusCode: 200..<300)
                        .responseDecodable(of: T.self) { response in
                            if let statusCode = response.response?.statusCode {
                                if statusCode == 419 {
                                    print("액세스 토큰 갱신 필요")
                                    self.refreshToken { success in /// 토큰 갱신에 성공하면 네트워크 재호출, 실패하면 에러 처리
                                        if success {
                                            makeRequest()
                                        } else {
                                            if let networkError = NetworkErrorCase(rawValue: statusCode) {
                                                observer(.success(.failure(networkError)))
                                            } else {
                                                observer(.success(.failure(NetworkErrorCase.UnknownError)))
                                            }
                                        }
                                    }
                                } else {
                                    switch response.result {
                                    case .success(let value):
                                        observer(.success(.success(value)))
                                    case .failure(_):
                                        if let networkError = NetworkErrorCase(rawValue: statusCode) {
                                            observer(.success(.failure(networkError)))
                                        } else {
                                            observer(.success(.failure(NetworkErrorCase.UnknownError)))
                                        }
                                    }
                                }
                            }
                        }
                }
                
                makeRequest()
                return Disposables.create()
            } catch {
                print("API URLRequestConvertible Failed")
                return Disposables.create()
            }
        }.debug("API 네트워크 통신 >>>")
    }

    func refreshToken(completion: @escaping (Bool) -> Void) {
        print("토큰 갱신 시작")
        do {
            let request = try UserRouter.accessToken.asURLRequest()
            
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: RefreshTokenResponse.self) { response in
                    if let statusCode = response.response?.statusCode {
                        if statusCode == 418 {
                            print("리프레시 토큰 갱신 필요. 로그인 화면으로 전환.") /// RootViewController 로그인 화면으로 변경 + UserDefaults 제거
                            NavigationManager.shared.changeRootViewControllerToLogin()
                            UserDefaultsManager.deleteAllUserDefaults()
                        } else {
                            switch response.result {
                            case .success(let value):
                                UserDefaultsManager.accessToken = value.accessToken /// 성공했을 때 AccessToken 교체
                                completion(true)
                            case .failure(_):
                                print("리프레시 토큰 갱신 오류")
                                if let networkError = NetworkErrorCase(rawValue: statusCode) {
                                    print(networkError)
                                } else {
                                    print(NetworkErrorCase.UnknownError)
                                }
                                completion(false)
                            }
                        }
                    }
                }
        } catch {
            print("Refresh URLRequestConvertible Failed")
        }
    }
    
}
