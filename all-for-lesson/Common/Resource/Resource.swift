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
        static let white: UIColor = .init(0xffffff)
        static let whiteSmoke: UIColor = .init(0xfcfcfc)
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
        static let bold12 = UIFont(name: "Pretendard-Bold", size: 12)
        static let medium12 = UIFont(name: "Pretendard-Medium", size: 12)
        static let regular16 = UIFont(name: "Pretendard-Regular", size: 16)
        static let regular14 = UIFont(name: "Pretendard-Regular", size: 14)
        static let regular12 = UIFont(name: "Pretendard-Regular", size: 12)
    }
    
    enum SystemImage {
        static let leftArrow = UIImage(systemName: "arrow.left")!
        static let home = UIImage(systemName: "house")!
        static let piano = UIImage(systemName: "pianokeys")!
        static let search = UIImage(systemName: "magnifyingglass")!
        static let board = UIImage(systemName: "square.and.pencil")!
        static let person = UIImage(systemName: "person")!
        static let star = UIImage(systemName: "star.fill")!
        static let bookmark = UIImage(systemName: "bookmark")!
        static let bookmarkFill = UIImage(systemName: "bookmark.fill")!
        static let gear = UIImage(systemName: "gearshape")!
        static let list = UIImage(systemName: "list.bullet.clipboard.fill")!
        static let friends = UIImage(systemName: "person.2.fill")!
        static let plus = UIImage(systemName: "plus.circle")!
        
        /// 홈 메뉴 버튼
        static let homeMenus: [UIImage] = [
            .folder, .violin, .flute, .brass,
            .piano, .microphone, .clef, .percussion
        ]
        /// 마이페이지 버튼
        static let mypageButtons: [UIImage]  = [.board, .bookmark, .friends]
    }
    
}
