//
//  LoginResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import Foundation

/// 로그인
struct LoginResponse: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let profileImage: String?
    let accessToken: String
    let refreshToken: String
}
