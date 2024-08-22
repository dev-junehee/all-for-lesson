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
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let URL = try base.asURL()
        var request = try URLRequest(url: URL.appendingPathComponent(path), method: method)
        request.allHTTPHeaderFields = header
        request.httpBody = body
        // request.httpBody = parameters?.data(using: .utf8)
        return request
    }
}
