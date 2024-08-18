//
//  UserDefaultsManager.swift
//  all-for-lesson
//
//  Created by junehee on 8/17/24.
//

import Foundation

enum UserDefaultsKey: String {
    // case userType   /// `0` - 수강생 `1` - 선생님
    case userId
    case email
    case nick
    case profileImage
    case accessToken
    case refreshToken
}

struct UserDefaultsManager {
    // @UserDefaultsWrapper (key: .userType, defaultValue: "Not User")
    // static var userType: String
    
    @UserDefaultsWrapper (key: .userId, defaultValue: "No User Id")
    static var userId: String
    
    @UserDefaultsWrapper (key: .email, defaultValue: "No Email")
    static var email: String
    
    @UserDefaultsWrapper (key: .nick, defaultValue: "Guest")
    static var nick: String
    
    @UserDefaultsWrapper (key: .profileImage, defaultValue: "")
    static var profileImage: String
    
    @UserDefaultsWrapper (key: .accessToken, defaultValue: "")
    static var accessToken: String
    
    @UserDefaultsWrapper (key: .refreshToken, defaultValue: "")
    static var refreshToken: String
    
    static func deleteAllUserDefaults() {
        // _userType.delete()
        _userId.delete()
        _email.delete()
        _nick.delete()
        _accessToken.delete()
        _refreshToken.delete()
    }
}

@propertyWrapper
struct UserDefaultsWrapper<T> {
    let key: UserDefaultsKey
    let defaultValue: T
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
    
    var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key.rawValue) as? T ?? defaultValue
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: key.rawValue)
        }
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
    }
}
