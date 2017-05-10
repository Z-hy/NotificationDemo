//
//  MediaViewController.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

class MediaViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBAction methods
    @IBAction func tapNotificationButtonAction(_ sender: Any) {
        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = "Image Notification"
        content.body = "Show me an image!"
        if let imageURL = Bundle.main.url(forResource: "image", withExtension: "jpg"), let attachment = try? UNNotificationAttachment(identifier: "imageAttachment", url: imageURL, options: nil) {
            content.attachments = [attachment]
        }
        // Create a trigger to dicide when/where to present the notification
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = UserNotificationType.media.rawValue
        
        // The request describes this notification
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Media Notification scheduled: \(requestIdentifier)")
            }
        }
    }
}
