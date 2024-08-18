//
//  JoinResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import Foundation

struct JoinResponse: Decodable {
    let user_id: String
    let email: String
    let nick: String
}
