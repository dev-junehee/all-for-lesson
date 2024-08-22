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
    case getPosts
}

extension PostRouter: TargetType {
    
    var base: String {
        API.URL.Base.dev
    }
    
    var path: String {
        switch self {
        case .posts, .getPosts: API.URL.posts
        case .postFiles: API.URL.posts + API.URL.files
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts, .postFiles:
                .post
        case .getPosts:
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
        case .getPosts:
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
        case .getPosts:
            return nil
        }
    }
}
