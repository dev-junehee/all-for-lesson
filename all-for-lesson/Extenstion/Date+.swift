//
//  Date+.swift
//  all-for-lesson
//
//  Created by junehee on 12/7/24.
//

import Foundation

extension Date {
    func getFormattedDateString() -> String {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy. MM. dd"
        outputFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")

        return outputFormatter.string(from: self)
    }
}
