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
    
    func apiCall<T: Decodable>(api: APIRouter, of type: T.Type) -> Single<Result<T, NetworkErrorCase>> {
        return Single<Result<T, NetworkErrorCase>>.create { observer -> Disposable in
            do {
                var request = try api.asURLRequest()
                
                func callRequest(isRefresh: Bool = false) {
                    /// 토큰 리프레시 후 다시 API Call 시도할 때 request도 갱신 해주기
                    if isRefresh {
                        do {
                            request = try api.asURLRequest()
                        } catch {
                            print("API URLRequestConvertible Failed - Refresh", error)
                        }
                    }
                    print("URL >>>", request.url)
                    AF.request(request)
                        .validate(statusCode: 200..<300)
                        .responseDecodable(of: T.self) { response in
                            guard let statusCode = response.response?.statusCode else { return }
                            print("상태코드 확인 >>>", statusCode)
                            if statusCode == 419 {
                                print("액세스 토큰 갱신 필요")
                                self.refreshToken { success in /// 토큰 갱신에 성공하면 네트워크 재호출, 실패하면 에러 처리
                                    print("토큰 갱신 결과", success)
                                    if success {
                                        callRequest(isRefresh: true)
                                        return
                                    } else {
                                        guard let networkError = NetworkErrorCase(rawValue: statusCode) else {
                                            return observer(.success(.failure(NetworkErrorCase.UnknownError)))
                                        }
                                        observer(.success(.failure(networkError)))
                                    }
                                }
                                return
                            }
                            switch response.result {
                            case .success(let value):
                                observer(.success(.success(value)))
                            case .failure(_):
                                guard let networkError = NetworkErrorCase(rawValue: statusCode) else {
                                    return observer(.success(.failure(NetworkErrorCase.UnknownError)))
                                }
                                observer(.success(.failure(networkError)))
                            }
                        }
                }
                
                callRequest()
                return Disposables.create()
            } catch {
                print("API URLRequestConvertible Failed", error)
                return Disposables.create()
            }
        }.debug("API 네트워크 통신 >>>")
    }
    
    
    func uploadFiles(files: [Data?], fileNames: [String?]) -> Single<Result<PostFilesResponse, NetworkErrorCase>> {
        let URL = API.URL.base + API.URL.posts + API.URL.files
        let headers: HTTPHeaders = [
            API.Header.auth: UserDefaultsManager.accessToken,
            API.Header.contentType: API.Header.multipart,
            API.Header.sesacKey: API.KEY.key
        ]
        
        return Single<Result<PostFilesResponse, NetworkErrorCase>>.create { observer -> Disposable in
            AF.upload(multipartFormData: { multipartFormData in
                for (i, file) in files.enumerated() {
                    if let fileData = file, let fileName = fileNames[i] {
                        multipartFormData.append(fileData, withName: "files", fileName: fileName, mimeType: "image/jpg")
                    }
                }
            }, to: URL, method: .post, headers: headers)
            .validate(statusCode: 200...299)
            .responseDecodable(of: PostFilesResponse.self) { response in
                if let statusCode = response.response?.statusCode {
                    switch response.result {
                    case .success(let value):
                        observer(.success(.success(value)))
                    case .failure:
                        if let networkError = NetworkErrorCase(rawValue: statusCode) {
                            observer(.success(.failure(networkError)))
                        } else {
                            observer(.success(.failure(NetworkErrorCase.UnknownError)))
                        }
                    }
                }
            }
            return Disposables.create()
        }.debug("Post Files 네트워크 통신 >>>")
    }
    
    // func postReservation(id: String, reservation: Bool) {
    //     let URL = API.URL.posts + id + API.URL.bookmark
    //     let headers: HTTPHeaders = [
    //         API.Header.auth: UserDefaultsManager.accessToken,
    //         API.Header.sesacKey: API.KEY.key
    //     ]
    //     let params: [String: Bool] = [
    //         "like_status": reservation
    //     ]
    //     
    //     AF.request(URL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers)
    //         .responseDecodable(of: ReservationResponse.self) { result in
    //             switch result.result {
    //             case .success(let value):
    //                 print(value)
    //             case .failure(let error):
    //                 print(error)
    //             }
    //         }
    // }
    
    func getImage(_ file: String, completion: @escaping (Data) -> Void) {
        let URL = API.URL.base + file
        let headers: HTTPHeaders = [
            API.Header.auth: UserDefaultsManager.accessToken,
            API.Header.sesacKey: API.KEY.key
        ]
        
        AF.request(URL, headers: headers)
            .responseString { response in
                if let imageData = response.data {
                    completion(imageData)
                }
            }
    }
    
    func getPostDetail(_ id: String, completion: @escaping (Result<Post, AFError>) -> Void) {
        let router = PostRouter.getPostsDetail(id: id)
        do {
            let request = try router.asURLRequest()
            AF.request(request)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: Post.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        } catch {
            print("getPostDetail URLRequestConvertible Failed", error)
        }
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
                            print("((( \(statusCode) )))")
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

