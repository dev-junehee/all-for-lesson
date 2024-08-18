//
//  UIView+.swift
//  all-for-lesson
//
//  Created by junehee on 8/16/24.
//

import UIKit

extension UIView: Reusable {
    static var id: String {
        return String(describing: self)
    }
}
