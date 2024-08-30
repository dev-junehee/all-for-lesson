//
//  TargetType.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String] { get }
    var body: Data? { get }
    var query: [URLQueryItem]? { get }
}

extension TargetType {
    /// 바디 사용
    // func asURLRequest() throws -> URLRequest {
    //     let URL = try base.asURL()
    //     var request = try URLRequest(url: URL.appendingPathComponent(path), method: method)
    //     request.allHTTPHeaderFields = header
    //     request.httpBody = body
    //     return request
    // }
    
    func asURLRequest() throws -> URLRequest {
        let base = try base.asURL()
  
        var components = URLComponents(url: base.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        
        /// query를 사용하는 경우
        components?.queryItems = query
        
        /// 예외처리
        guard let URL = components?.url else { throw URLError(.badURL) }
        
        var request = try URLRequest(url: URL, method: method)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        return request
    }

}
