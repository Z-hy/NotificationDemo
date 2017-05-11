//
//  ManagementViewController.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

class ManagementViewController: UIViewController {
    
    let title1Content: UNNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "1"
        content.body = "Notification 1"
        return content
    }()
    
    let title2Content: UNNotificationContent = {
        let content = UNMutableNotificationContent()
        content.title = "2"
        content.body = "Notification 2"
        return content
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction
    @IBAction func tapPendingRemovalButton(_ sender: Any) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingRemoval.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier)")
            }
        }
        delay(5) {
            print("Notification request removed: \(identifier)")
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
        }
    }
    
    @IBAction func tapPendingUpdateButton(_ sender: Any) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingUpdate.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier) with title1")
            }
        }
        delay(5) {
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            // Add new request with the same identifier to update a notification.
            let newRequest = UNNotificationRequest(identifier: identifier, content: self.title2Content, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequest) { error in
                if let error = error {
                    UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
                } else {
                    print("Notification request updated: \(identifier) with title2")
                }
            }
        }
    }
    
    @IBAction func tapDeliveredRemovalButton(_ sender: Any) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.deliveredRemoval.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier)")
            }
        }
        delay(4) {
            print("Notification request removed: \(identifier)")
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [identifier])
        }
    }
    
    @IBAction func tapDeliveredUpdateButton(_ sender: Any) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        let identifier = UserNotificationType.pendingUpdate.rawValue
        let request = UNNotificationRequest(identifier: identifier, content: title1Content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Notification request added: \(identifier) with title1")
            }
        }
        delay(4) {
            let newTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            // Add new request with the same identifier to update a notification.
            let newRequest = UNNotificationRequest(identifier: identifier, content: self.title2Content, trigger: newTrigger)
            UNUserNotificationCenter.current().add(newRequest) { error in
                if let error = error {
                    UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
                } else {
                    print("Notification request updated: \(identifier) with title2")
                }
            }
        }
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
