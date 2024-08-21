//
//  MyProfileResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import Foundation

/// 내 프로필 조회
struct MyProfileResponse: Decodable {
    let user_id: String
    let email: String
    let nick: String
    let phoneNum: String
    let birthDay: String
    let profileImage: String?
    let posts: [String]
}
