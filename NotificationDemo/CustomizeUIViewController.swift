//
//  CustomizeUIViewController.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit
import UserNotifications

class CustomizeUIViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - IBAction
    @IBAction func tapShowNotificationButon(_ sender: Any) {
        let content = UNMutableNotificationContent()
        content.title = "Image Notification"
        content.body = "Show me some images!"
        let imageNames = ["image", "onevcat"]
        let attachments = imageNames.flatMap { name -> UNNotificationAttachment? in
            if let imageURL = Bundle.main.url(forResource: name, withExtension: "jpg") {
                return try? UNNotificationAttachment(identifier: "image-\(name)", url: imageURL, options: nil)
            }
            return nil
        }
        content.attachments = attachments
        content.userInfo = ["items": [["title": "Photo 1", "text": "Cute girl"], ["title": "Photo 2", "text": "Cute cat"]]]
        // Set category to use customized UI
        content.categoryIdentifier = UserNotificationCategoryType.customUI.rawValue
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let requestIdentifier = UserNotificationType.customUI.rawValue
        
        let request = UNNotificationRequest(identifier: requestIdentifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                UIAlertController.showConfirmAlert(error.localizedDescription, in: self)
            } else {
                print("Customized UI Notification scheduled: \(requestIdentifier)")
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
