//
//  MyPaymentsResponse.swift
//  all-for-lesson
//
//  Created by junehee on 9/8/24.
//

import Foundation

struct MyPaymentsResponse: Decodable {
    let data: [PayValidationResponse]?
}
