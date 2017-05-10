//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by user on 2017/5/9.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

let PushTokenKey: String = "push-token"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationHandler = NotificationHandler()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        registerNotificationCategory()
        UNUserNotificationCenter.current().delegate = notificationHandler
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.hexString
        UserDefaults.standard.set(tokenString, forKey: PushTokenKey)
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: .AppDidReceivedRemoteNotificationDeviceToken, object: nil, userInfo: [Notification.Key.AppDidReceivedRemoteNotificationDeviceTokenKey: tokenString])
        
        print("Get Push token: \(tokenString)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        UserDefaults.standard.set("", forKey: PushTokenKey)
    }

    func createPushContent() {
        //1. 创建通知内容
        let content = UNMutableNotificationContent()
        content.title = "Time Interval Notificaiton"
        content.body = "My first notification"
        content.userInfo = ["name": "zhy"]
        //2. 创建发送触发
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        //3. 发送请求标识符
        let requestIdentifier = "com.zhy.usernotification,myFirstNotification"
        //4. 创建一个发送请求
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        //5. 将请求添加到发送中心
        UNUserNotificationCenter.current().add(request) { (error) in
            if error == nil {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
            }
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    // 注册category
    private func registerNotificationCategory() {
        let saySomethingCategory: UNNotificationCategory = {
            // 1
            let inputActon = UNTextInputNotificationAction(identifier: "action.input", title: "Input", options:[.foreground], textInputButtonTitle: "Send", textInputPlaceholder: "What do you want to say...")
            // 2
            let goodbyeAction = UNNotificationAction(identifier: "action.goodbye", title: "Goodbye", options:[.foreground])
            // 3
            let cancelActon = UNNotificationAction(identifier: "action.cancel", title: "Cancel", options:[.destructive])
            //
            return UNNotificationCategory(identifier: "saySomethingCategory", actions: [inputActon, goodbyeAction, cancelActon], intentIdentifiers: [], options: [.customDismissAction])
        }()
        let customUICategory: UNNotificationCategory = {
            let nextAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.switche.rawValue,
                title: "Switch",
                options: [])
            let openAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.open.rawValue,
                title: "Open",
                options: [.foreground])
            let dismissAction = UNNotificationAction(
                identifier: CustomizeUICategoryAction.dismiss.rawValue,
                title: "Dismiss",
                options: [.destructive])
            return UNNotificationCategory(identifier: UserNotificationCategoryType.customUI.rawValue, actions: [nextAction, openAction, dismissAction], intentIdentifiers: [], options: [])
        }()
        UNUserNotificationCenter.current().setNotificationCategories([saySomethingCategory, customUICategory])
    }
}

extension Notification.Name {
    static let AppDidReceivedRemoteNotificationDeviceToken = Notification.Name(rawValue: "com.onevcat.usernotification.AppDidReceivedRemoteNotificationDeviceToken")
}

extension Notification {
    struct Key {
        static let AppDidReceivedRemoteNotificationDeviceTokenKey = "token"
    }
}
