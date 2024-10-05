//
//  PostQuery.swift
//  all-for-lesson
//
//  Created by junehee on 8/25/24.
//

import Foundation

struct PostQuery: Encodable {
    let next: String?
    let limit: String?
    let product_id: String?
}
