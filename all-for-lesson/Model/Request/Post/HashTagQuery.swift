//
//  HashTagQuery.swift
//  all-for-lesson
//
//  Created by junehee on 8/30/24.
//

import Foundation

struct HashTagQuery: Encodable {
    let next: String?
    let limit: String?
    let product_id: String?
    let hashTag: String?
}
