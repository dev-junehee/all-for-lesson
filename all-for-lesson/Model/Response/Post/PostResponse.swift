//
//  PostResponse.swift
//  all-for-lesson
//
//  Created by junehee on 8/19/24.
//

import Foundation

struct PostResponse: Decodable {
    let data: [Post]
}

struct Post: Decodable, Hashable {
    let post_id: String
    let product_id: String
    let title: String
    let price: Int
    let content: String?
    let content1: String?
    let content2: String?
    let content3: String?
    let content4: String?
    let content5: String?
    let createAt: String?
    let creator: Creator
    let files: [String]
    let likes: [String]
    let likes2: [String]
    let hashTags: [String]
    let comments: [Comment]
}

struct Creator: Decodable, Hashable {
    let user_id: String
    let nick: String
    let profileImage: String?
}

struct Comment: Decodable, Hashable {
    let comment_id: String
    let content: String
    let createAt: String
    let creator: Creator
}
