//
//  Constant.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation

enum Constant {
    
    enum Onboarding {
        static let welcome = "환영합니다!\n어떤 유형으로 가입하시겠어요?"
        static let student = "수강생"
        static let studentDescription = "음악 레슨을 찾고 있어요"
        static let teacher = "선생님"
        static let teacherDescription = "레슨 수강생을 찾고 있어요"
        static let account = "이미 계정이 있으신가요?"
        static let login = "로그인"
    }
    
    enum Home {
        static let menu = ["전체보기", "현악기", "목관악기", "금관악기", "피아노", "성악", "클래식작곡", "그 외"]
        static let popular = "실시간 인기 레슨"
        static let interesting = "이걸 배워? 흥미돋는 레슨!"
    }
    
    enum MyPage {
        enum Menu {
            static let student = ["로그아웃", "회원탈퇴"]
            static let teacher = ["레슨 개설하기", "로그아웃", "회원탈퇴"]
        }
    }
    
    enum Lesson {
        static let major = [
            "피아노", "성악", "클래식 작곡",
            "바이올린", "비올라", "첼로", "콘트라베이스",
            "플룻", "오보에", "클라리넷", "바순",
            "트럼펫", "트롬본", "튜바", "호른", "색소폰",
            "타악기", "하프"
        ]
        
        static let location = [
            "서울", "경기", "인천", "대전", "충청", "세종",
            "광주", "전남", "전북", "강원", "대구", "울산",
            "부산", "경남", "경북"
        ]
        
        static let type = ["취미", "입시"]
    }
    
}
