//
//  APIRouter.swift
//  all-for-lesson
//
//  Created by junehee on 8/23/24.
//

import Foundation
import Alamofire

enum APIRouter {
    case user(UserRouter)
    case post(PostRouter)
}

extension APIRouter: TargetType {
    
    var base: String {
        switch self {
        case .user(let userRouter): userRouter.base
        case .post(let postRouter): postRouter.base
        }
    }
    
    var path: String {
        switch self {
        case .user(let userRouter): userRouter.path
        case .post(let postRouter): postRouter.path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .user(let userRouter): userRouter.method
        case .post(let postRouter): postRouter.method
        }
    }
    
    var header: [String : String] {
        switch self {
        case .user(let userRouter): userRouter.header
        case .post(let postRouter): postRouter.header
        }
    }
    
    var body: Data? {
        switch self {
        case .user(let userRouter): userRouter.body
        case .post(let postRouter): postRouter.body
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .user(let userRouter): userRouter.query
        case .post(let postRouter): postRouter.query
        }
    }
    
}
