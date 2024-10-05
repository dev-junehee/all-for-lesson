//
//  UserRouter.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation
import Alamofire

/**
 `join` 회원가입
 `email` 이메일 중복 확인
 `login` 로그인
 `accessToken` 액세스 토큰 갱신
 `withdraw`회원탈퇴
 */

enum UserRouter {
    case join(body: JoinBody)               /// 회원가입
    case email(body: EmailBody)             /// 이메일 중복 확인
    case login(body: LoginBody)             /// 로그인
    case getMyProfile                       /// 내 프로필
    case accessToken                        /// 토큰 갱신
    case withdraw                           /// 회원 탈퇴
    case getUserProfile(id: String)         /// 다른 사람 프로필=
}

extension UserRouter: TargetType {
    
    var base: String {
        return API.URL.base
    }
    
    var path: String {
        switch self {
        case .join: API.URL.join
        case .email: API.URL.email
        case .login: API.URL.login
        case .accessToken: API.URL.refresh
        case .withdraw: API.URL.withdraw
        case .getMyProfile: API.URL.myProfile
        case .getUserProfile(let id): API.URL.users + id + API.URL.profile
        }
    }
    
    var method: HTTPMethod  {
        switch self {
        case .join, .email, .login:
            return .post
            
        case .accessToken, .withdraw, .getMyProfile, .getUserProfile:
            return .get
        }
    }
    
    var header: [String: String] {
        switch self {
        case .join, .email, .login:
            return [
                API.Header.contentType: API.Header.json,
                API.Header.sesacKey: API.KEY.key
            ]
            
        case .accessToken:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.sesacKey: API.KEY.key,
                API.Header.refresh: UserDefaultsManager.refreshToken
            ]
            
        case .getMyProfile, .getUserProfile, .withdraw:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.contentType: API.Header.json,
                API.Header.sesacKey: API.KEY.key
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .join(let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
        case .email(let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
        case .login(let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
        case .getMyProfile, .getUserProfile, .accessToken, .withdraw:
            return nil
        }
    }
    
    var query: [URLQueryItem]? {
        return nil
    }
    
}
