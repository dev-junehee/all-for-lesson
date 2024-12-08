//
//  ToastManager.swift
//  all-for-lesson
//
//  Created by junehee on 8/25/24.
//

import UIKit
import Toast

final class ToastManager {
    
    static let shared = ToastManager()
    private var style: ToastStyle
    
    private init() {
        style = ToastStyle()
        style.backgroundColor = Resource.Color.skyblue
        style.messageColor = Resource.Color.fontBlack
        style.messageAlignment = .center
    }
    
    func showToast(_ message: String, position: ToastPosition = .bottom, duration: TimeInterval = 3.0) {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            let keyWindow = scene.windows.first(where: { $0.isKeyWindow })
            keyWindow?.rootViewController?.view.makeToast(message, duration: duration, position: position, style: style)
        }
    }
    
}

