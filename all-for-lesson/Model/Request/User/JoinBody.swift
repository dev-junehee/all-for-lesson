//
//  JoinBody.swift
//  all-for-lesson
//
//  Created by junehee on 8/22/24.
//

import Foundation

struct JoinBody: Encodable {
    let email: String
    let password: String
    let nick: String
    let phoneNum: String
}
