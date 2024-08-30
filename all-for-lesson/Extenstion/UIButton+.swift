//
//  UIButton+.swift
//  all-for-lesson
//
//  Created by junehee on 8/21/24.
//

import UIKit

extension UIButton {
    func setButtonUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
