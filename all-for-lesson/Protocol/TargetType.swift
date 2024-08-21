//
//  TargetType.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation
import Alamofire

protocol TargetType {
    var base: String { get }
    var endPoint: URL { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var params: Parameters { get }
}


