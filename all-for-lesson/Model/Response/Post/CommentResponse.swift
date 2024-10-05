//
//  CommentResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/27/24.
//

import Foundation

struct CommentResponse: Decodable, Hashable {
    let comment_id: String
    let content: String
    let createdAt: String
    let creator: Creator
}
