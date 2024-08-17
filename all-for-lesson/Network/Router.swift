//
//  Router.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import Alamofire

enum Router {
    case join(email: String, password: String, nick: String, phoneNum: String)
    case email(email: String)
    case login(email: String, password: String)
    case accessToken(accessToken: String, refreshToken: String)
    case withdraw(accessToken: String)
    case postFiles(accessToken: String)
}

extension Router: TargetType {
    
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
            return URL(string: base + API.URL.accessToken)!
            
        case .withdraw:
            return URL(string: base + API.URL.withdraw)!
            
        case .postFiles:
            return URL(string: base + API.URL.postFiles)!
        }
    }
    
    var method: HTTPMethod  {
        switch self {
        case .join, .email, .login, .postFiles:
            return .post
            
        case .accessToken, .withdraw:
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
            
        case .accessToken(let accessToken, let refreshToken):
            return [
                API.Header.auth: accessToken,
                API.Header.sesacKey: API.KEY.key,
                API.Header.refresh: refreshToken
            ]
            
        case .withdraw(let accessToken):
            return [
                API.Header.auth: accessToken,
                API.Header.sesacKey: API.KEY.key
            ]
            
        case .postFiles(let accessToken):
            return [
                API.Header.auth: accessToken,
                API.Header.contentType: API.Header.multipart,
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
        case .postFiles:
            return [
                "files": Data()
            ]
        case .accessToken, .withdraw:
            return [:]
        }
    }
    
}
