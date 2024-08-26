//
//  PostRouter.swift
//  all-for-lesson
//
//  Created by junehee on 8/22/24.
//

import Foundation
import Alamofire

/**
 `posts` 포스트 작성
 `postsFiles`파일 업로드
 `getPosts`포스트 조회
 */

enum PostRouter {
    case posts(body: PostBody)
    case postFiles(body: PostFilesBody)
    case getPosts(query: PostQuery)
    case getImage(query: String)
}

extension PostRouter: TargetType {
    
    var base: String {
        API.URL.Base.dev
    }
    
    var path: String {
        switch self {
        case .posts: API.URL.posts
        case .postFiles: API.URL.posts + API.URL.files
        case .getPosts: API.URL.posts
        case .getImage: ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts, .postFiles:
                .post
        case .getPosts, .getImage:
                .get
        }
    }
    
    var header: [String: String] {
        switch self {
        case .posts:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.contentType: API.Header.json,
                API.Header.sesacKey: API.KEY.key
            ]
        case .postFiles:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.contentType: API.Header.multipart,
                API.Header.sesacKey: API.KEY.key
            ]
        case .getPosts, .getImage:
            return [
                API.Header.auth: UserDefaultsManager.accessToken,
                API.Header.sesacKey: API.KEY.key
            ]
        }
    }
    
    var body: Data? {
        switch self {
        case .posts(let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
            
        case .postFiles(let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
            
        case .getPosts, .getImage:
            return nil
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .posts, .postFiles:
            return nil
        
        case .getPosts(let query):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(query)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return json.map { URLQueryItem(name: $0, value: "\($1)") }
                } else {
                    return nil
                }
            } catch {
                print("json encode error", error)
                return nil
            }
        
        case .getImage(let query):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(query)
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    return json.map { URLQueryItem(name: "", value: "\($0)") }
                } else {
                    return nil
                }
            } catch {
                print("json encode error", error)
                return nil
            }
        }
    }
    
}
