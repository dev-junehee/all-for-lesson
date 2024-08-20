//
//  WithDrawResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import Foundation

/// 회원탈퇴
struct WithDrawResponse: Decodable {
    let user_id: String
    let email: String
    let nick: String
}
