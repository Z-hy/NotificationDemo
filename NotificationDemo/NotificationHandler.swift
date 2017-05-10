//
//  NotificationHandler.swift
//  NotificationDemo
//
//  Created by user on 2017/5/9.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

enum UserNotificationType: String {
    case timeInterval
    case timeIntervalForeground
    case pendingRemoval
    case pendingUpdate
    case deliveredRemoval
    case deliveredUpdate
    case actionable
    case mutableContent
    case media
    case customUI
}

extension UserNotificationType {
    var descriptionText: String {
        switch self {
            case .timeInterval:
                return "You need to switch to background to see the notification."
            case .timeIntervalForeground:
                return "The notification will show in-app. See NotificationHandler for more."
            default:
                return rawValue
        }
    }
    
    var title: String {
        switch self {
        case .timeInterval:
            return "Time"
        case .timeIntervalForeground:
            return "Foreground"
        default:
            return rawValue
        }
    }
}

enum UserNotificationCategoryType: String {
    case saySomething
    case customUI
}

enum SaySomethingCategoryAction: String {
    case input
    case goodbye
    case none
}

enum CustomizeUICategoryAction: String {
    case switche
    case open
    case dismiss
}

class NotificationHandler: NSObject,UNUserNotificationCenterDelegate  {

    // 应用内展示通知
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
        // 如果不想显示某个通知，可以直接用空 options 调用 completionHandler:
        // completionHandler()
    }
    
    // 这个代理方法会在用户与你推送的通知进行交互时被调用，包括用户通过通知打开了你的应用，或者点击或者触发了某个 action (我们之后会提到 actionable 的通知)。
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if let category = UserNotificationCategoryType(rawValue: response.notification.request.content.categoryIdentifier) {
            switch category {
                case .saySomething:
                    handleSaySomthing(response: response)
                    break
                case .customUI:
                    handleCustomUI(response: response)
            }
        }
        completionHandler()
    }
    
    private func handleSaySomthing(response: UNNotificationResponse) {
        let text: String
        if let actionType = SaySomethingCategoryAction(rawValue: response.actionIdentifier) {
            switch actionType {
            case .input: text = (response as! UNTextInputNotificationResponse).userText
            case .goodbye: text = "Goodbye"
            case .none: text = ""
            }
        } else {
            // Only tap or clear. (You will not receive this callback when user clear your notification unless you set .customDismissAction as the option of category)
            text = ""
        }
        if !text.isEmpty {
            UIAlertController.showConfirmAlertFromTopViewController("You just said \(text)")
        }
    }
    
    private func handleCustomUI(response: UNNotificationResponse) {
        print(response.actionIdentifier)
    }
}
