//
//  Constant.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import Foundation

enum Constant {
    
    static let allforlesson = "올포레슨"
    
    enum Tab {
        static let home = "홈"
        static let hashtag = "해시태그"
        static let community = "커뮤니티"
        static let mypage = "마이페이지"
    }
    
    enum Onboarding {
        static let welcome = "환영합니다!\n어떤 유형으로 가입하시겠어요?"
        static let student = "수강생"
        static let studentDescription = "음악 레슨을 찾고 있어요"
        static let teacher = "선생님"
        static let teacherDescription = "레슨 수강생을 찾고 있어요"
        static let account = "이미 계정이 있으신가요?"
        static let login = "로그인"
    }
    
    enum Join {
        static let email = "이메일을 입력해 주세요"
        static let password = "비밀번호를 입력해 주세요"
        static let nick = "닉네임을 입력해 주세요"
        static let name = "이름을 입력해 주세요"
        static let duplication = "중복 확인"
        static let join = "가입하기"
        static let signUp = "회원가입"
    }
    
    enum Login {
        static let login = "로그인"
        static let noAccount = "아직 계정이 없으신가요?"
    }
    
    enum Home {
        static let menu = ["전체보기", "현악기", "목관악기", "금관악기", "피아노", "성악", "클래식작곡", "그 외"]
        static let popular = "실시간 인기 레슨"
        static let interesting = "이걸 배워? 흥미돋는 레슨!"
    }
    
    enum HashTag {
        static let recommend = [
            "개인레슨", "그룹레슨", "입시레슨", "취미레슨", "예중", "예고", "음대입시",
            "피아노", "클래식작곡", "바이올린", "비올라", "첼로", "콘트라베이스", "플룻", "오보에", 
            "클라리넷", "바순", "트럼펫", "트롬본", "튜바", "호른", "색소폰", "팀파니", "타악기",
            "하프", "마림바", "실내악", "조성진", "손열음"
        ]
        static let title = "#해시태그를\n검색해 보세요!"
        static let result = "검색 결과"
        static let hashtag = "#해시태그"
        static let search = "어떤 해시태그를 찾으시나요?"
        static let recommendHashtag = "추천 해시태그"
    }
    
    enum MyPage {
        enum Menu {
            static let student = ["로그아웃", "오픈소스 라이선스", "고객센터", "회원탈퇴"]
            static let teacher = ["레슨 개설하기", "로그아웃", "오픈소스 라이선스", "고객센터", "회원탈퇴"]
        }
        
        static let title = "마이페이지"
        static let myReservation = "나의 수강 내역"
        static let reservation = "수강 내역"
        static let myBookmark = "내가 북마크한 레슨"
        static let bookmark = "북마크한 레슨"
        static let myLesson = "나의 레슨 관리"
        static let myLessonComment = "레슨 수강 후기"
    }
    
    enum Lesson {
        static let lesson = "레슨"
        
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
        static let detailView = ["레슨 상세 정보", "레슨 후기"]
        
        static let newLesson = "새로운 레슨 개설하기"
        static let editLesson = "레슨 정보 수정"
        static let reservationLesson = "레슨 신청하기"
        static let lessonTitle = "레슨 제목"
        static let lessonPrice = "레슨 가격"
        static let lessonMajor = "레슨 과목"
        static let lessonLocation = "레슨 위치"
        static let lessonType = "레슨 타입"
        static let lessonContent = "레슨 소개"
        static let selected = "선택"
        static let photoSelected = "사진 선택"
        static let edit = "수정"
        static let submit = "등록"
        static let fileUpload = "파일 업로드"
        static let dm = "1:1 문의"
        static let lessonComment = "레슨 후기를 작성해 주세요!"
    }
    
    enum Community {
        static let community = "커뮤니티"
    }
    
}
