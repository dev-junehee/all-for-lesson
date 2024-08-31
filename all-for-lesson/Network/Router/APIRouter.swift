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
    case pay(PayRouter)
}

extension APIRouter: TargetType {
    
    var base: String {
        switch self {
        case .user(let userRouter): userRouter.base
        case .post(let postRouter): postRouter.base
        case .pay(let payRouter): payRouter.base
        }
    }
    
    var path: String {
        switch self {
        case .user(let userRouter): userRouter.path
        case .post(let postRouter): postRouter.path
        case .pay(let payRouter): payRouter.path
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .user(let userRouter): userRouter.method
        case .post(let postRouter): postRouter.method
        case .pay(let payRouter): payRouter.method
        }
    }
    
    var header: [String : String] {
        switch self {
        case .user(let userRouter): userRouter.header
        case .post(let postRouter): postRouter.header
        case .pay(let payRouter): payRouter.header
        }
    }
    
    var body: Data? {
        switch self {
        case .user(let userRouter): userRouter.body
        case .post(let postRouter): postRouter.body
        case .pay(let payRouter): payRouter.body
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .user(let userRouter): userRouter.query
        case .post(let postRouter): postRouter.query
        case .pay(let payRouter): payRouter.query
        }
    }
    
}
