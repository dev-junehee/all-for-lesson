//
//  RefreshTokenResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/18/24.
//

import Foundation

/// 액세스 토큰 갱신
struct RefreshTokenResponse: Decodable {
    let accessToken: String
}
