//
//  String+.swift
//  all-for-lesson
//
//  Created by junehee on 12/7/24.
//

import Foundation

extension String {
    // String -> Date -> String
    /// 원하는 형식의 문자열로 포맷팅
    func getFormattedDateString() -> String {
        // String -> Date
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        inputFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC 시간
        
        guard let date = inputFormatter.date(from: self) else { return self }
        
        // Date -> String
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy. MM. dd"
        outputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul") // 한국 시간

        return outputFormatter.string(from: date)
    }
}
