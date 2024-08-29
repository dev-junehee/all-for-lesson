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
 `getImage` 이미지 조회
 `getPostsDetail` 포스트 상세 조회
 `postReservation` 레슨 신청/취소
 `postBookmark` 레슨 북마크/취소
 `getMyReservatioin` 내가 수강한 레슨 리스트
 `getMyBookmark` 내가 북마크한 레슨 리스트
 */

enum PostRouter {
    case posts(body: PostBody)
    case postFiles(body: PostFilesBody)
    case getPosts(query: PostQuery)
    case getImage(query: String)
    case getPostsDetail(id: String)
    case postReservation(id: String, body: ReservationBookmarkBody)
    case postBookmark(id: String, body: ReservationBookmarkBody)
    case postComment(id: String, body: PostCommentBody)
    case getReservatioin
    case getBookmark
    case getUserPosts(id: String, query: PostQuery)
}

extension PostRouter: TargetType {
    
    var base: String {
        API.URL.base
    }
    
    var path: String {
        switch self {
        case .posts: API.URL.posts
        case .postFiles: API.URL.posts + API.URL.files
        case .getPosts: API.URL.posts
        case .getImage: ""
        case .getPostsDetail(let id): API.URL.posts + id
        case .postReservation(let id, _): API.URL.posts + id + API.URL.reservatioin
        case .postBookmark(let id, _): API.URL.posts + id + API.URL.bookmark
        case .postComment(let id, _): API.URL.posts + id + API.URL.comments
        case .getReservatioin: API.URL.posts + API.URL.getReservation
        case .getBookmark: API.URL.posts + API.URL.getBookmark
        case .getUserPosts(let id, _): API.URL.posts + API.URL.users + id
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .posts, .postFiles, .postReservation, .postBookmark, .postComment:
                .post
        case .getPosts, .getImage, .getPostsDetail, .getReservatioin, .getBookmark, .getUserPosts:
                .get
        }
    }
    
    var header: [String: String] {
        switch self {
        case .posts, .postReservation, .postBookmark, .postComment, .getReservatioin, .getBookmark, .getUserPosts:
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
        case .getPosts, .getImage, .getPostsDetail:
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
            
        case .postReservation(_, let body), .postBookmark(_, let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
            
        case .postComment(_, let body):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(body)
                return data
            } catch {
                print("json encode error", error)
                return nil
            }
            
        case .getPosts, .getImage, .getPostsDetail, .getReservatioin, .getBookmark, .getUserPosts:
            return nil
        }
    }
    
    var query: [URLQueryItem]? {
        switch self {
        case .posts, .postFiles, .postReservation, .postBookmark, .postComment, .getReservatioin, .getBookmark:
            return nil
        
        case .getPosts(let query), .getUserPosts(_, let query):
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
            
        case .getPostsDetail(let id):
            let encoder = JSONEncoder()
            do {
                let data = try encoder.encode(id)
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
