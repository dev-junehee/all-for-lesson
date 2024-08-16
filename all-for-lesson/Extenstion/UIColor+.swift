//
//  UIColor+.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

/// Hex 색상코드를 UIColor로 변경해주는 익스텐션
extension UIColor {
    
    convenience init(_ rgb: UInt, alpha: CGFloat = 1.0) {
       self.init(
          red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
          green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
          blue: CGFloat(rgb & 0x0000FF) / 255.0,
          alpha: CGFloat(alpha)
       )
    }
    
}
