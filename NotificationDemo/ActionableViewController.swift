//
//  ActionableViewController.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

class ActionableViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction
    @IBAction func tapShowNotificationButton(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.body = "Please say something."
        // The saySomething category is registered in AppDelegate
        content.categoryIdentifier = UserNotificationCategoryType.saySomething.rawValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let request = UNNotificationRequest(identifier: UserNotificationType.actionable.rawValue, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
