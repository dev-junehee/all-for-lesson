//
//  PostRequest.swift
//  all-for-lesson
//
//  Created by junehee on 8/22/24.
//

import Foundation

struct PostBody: Encodable {
    let title: String
    let price: Int
    let content: String
    let content1: String    /// 전공
    let content2: String    /// 위치
    let content3: String    /// 취미/입시
    let content4: String?
    let content5: String?
    let product_id: String
    let files: [String]
}
