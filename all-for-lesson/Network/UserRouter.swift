//
//  UserRouter.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation
import Alamofire

enum UserRouter {
    case join(email: String, password: String, nick: String, phoneNum: String)
    case email(email: String)
    case login(email: String, password: String)
    case profile
    case accessToken
    case withdraw
    
}

extension UserRouter: TargetType {
    
    var base: String {
        return API.URL.base
    }
    
    var endPoint: URL {
        switch self {
        case .join:
            return URL(string: base + API.URL.join)!
            
        case .email:
            return URL(string: base + API.URL.email)!
            
        case .login:
            return URL(string: base + API.URL.login)!
            
        case .accessToken:
            return URL(string: base + API.URL.refresh)!
            
        case .withdraw:
            return URL(string: base + API.URL.withdraw)!
            
        case .profile:
            return URL(string: base + API.URL.profile)!
        }
    }
    
    var method: HTTPMethod  {
        switch self {
        case .join, .email, .login:
            return .post
            
        case .accessToken, .withdraw, .profile:
            return .get
        }
    }
    
    var headers: HTTPHeaders {
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
            
        case .profile, .withdraw:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.sesacKey: API.KEY.key
            ]
        }
    }
    
    var params: Parameters {
        switch self {
        case .join(let email, let password, let nick, let phoneNum):
            return [
                "email": email,
                "password": password,
                "nick": nick,
                "phoneNum": phoneNum,
                "birthDay": ""
            ]
        case .email(let email):
            return [
                "email": email
            ]
        case .login(let email, let password):
            return [
                "email": email,
                "password": password
            ]
        case .profile, .accessToken, .withdraw:
            return [:]
        }
    }
    
}
