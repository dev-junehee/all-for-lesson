//
//  JoinResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import Foundation

/// 회원가입
struct JoinResponse: Decodable {
    let user_id: String
    let email: String
    let nick: String
}
