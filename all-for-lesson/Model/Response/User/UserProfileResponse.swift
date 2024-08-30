//
//  UserProfileResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import Foundation

struct UserProfileResponse: Decodable {
    let user_id: String
    let nick: String
    let profileImage: String?
    let posts: [String]
}
