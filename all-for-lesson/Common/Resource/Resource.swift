//
//  Resource.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

/**
 프로젝트 내 사용하는 리소스 모음
 `Color` - 기본 색상과 프라이머리 색상
 `Font` -
 
 */
enum Resource {
    
    enum Color {
        static let white: UIColor = .init(0xfcfcfc)
        static let paleGray: UIColor = .init(0xf6f6f6)
        static let lightGray: UIColor = .init(0xd9d9d9)
        static let darkGray: UIColor = .init(0x636363)
        static let ivory: UIColor = .init(0xfffff5)
        static let yellow: UIColor = .init(0xffda8e)
        static let skyblue: UIColor = .init(0x80d4f6)
        static let purple: UIColor = .init(0x5c196b)
        static let red: UIColor = .init(0xe53a40)
        static let fontBlack: UIColor = .init(0x333333)
        static let black: UIColor = .init(0x000000)
    }
    
    enum Font {
        static let viewTitle = UIFont(name: "Pretendard-Bold", size: 24)
        static let bold20 = UIFont(name: "Pretendard-Bold", size: 20)
        static let bold18 = UIFont(name: "Pretendard-Bold", size: 18)
        static let bold16 = UIFont(name: "Pretendard-Bold", size: 16)
        static let bold14 = UIFont(name: "Pretendard-Bold", size: 14)
        static let regular14 = UIFont(name: "Pretendard-Regular", size: 14)
        static let regular12 = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    
}
