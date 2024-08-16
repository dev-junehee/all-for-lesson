//
//  ValidationManager.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation

final class ValidationManager {
    
    static let shared = ValidationManager()
    private init() { }
    
    /// 이메일 유효성 검사 (임시)
    func emailValidation(_ email: String) -> Bool {
        if email.contains("@") {
            return true
        }
        return false
    }
    
    
    
}
