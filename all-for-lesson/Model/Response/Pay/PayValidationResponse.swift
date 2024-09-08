//
//  PayValidationResponse.swift
//  all-for-lesson
//
//  Created by junehee on 9/3/24.
//

import Foundation

struct PayValidationResponse: Decodable {
    let buyer_id: String
    let post_id: String
    let merchant_uid: String
    let productName: String
    let price: Int
    let paidAt: String
}
