//
//  TimeIntervalViewController.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

class TimeIntervalViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeTextField: UITextField!
    
    var notificationType: UserNotificationType!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = notificationType.title
        descriptionLabel.text = notificationType.descriptionText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction
    @IBAction func tapScheduleButton(_ sender: AnyObject) {
        guard let text = timeTextField.text, let timeInterval = TimeInterval(text) else { print("Not valid time interval"); return }
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Time Interval Notification"
        content.body = "My first notificaiton"
        
        // Create a trigger to decide when/where to present the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        
        // Create an identifier for this notification. So you could manage it later.
        let requestIdentifier = notificationType.rawValue
        
        // The request describes this notification.
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Time Interval Notification scheduled: \(requestIdentifier)")
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
