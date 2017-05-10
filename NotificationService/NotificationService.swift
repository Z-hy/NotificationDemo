//
//  NotificationService.swift
//  NotificationService
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UserNotifications

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?
    
    private func downloadAndSave(url: URL, handler: @escaping(_ localURL: URL?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            var localURL: URL? = nil
            
            if let data = data {
                let ext = (url.absoluteString as NSString).pathExtension
                let cacheURL = URL(fileURLWithPath: FileManager.default.cacheDirectory)
                let url = cacheURL.appendingPathComponent(url.absoluteString.md5).appendingPathComponent(ext)
                if let _ = try? data.write(to: url) {
                    localURL = url
                }
            }
            handler(localURL)
        }
        task.resume()
    }

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        if let bestAttemptContent = bestAttemptContent {
            // Modify the notification content here...
            if request.identifier == "mutableContent" {
                bestAttemptContent.body = "\(bestAttemptContent.body), zhy"
                contentHandler(bestAttemptContent)
            } else if request.identifier == "media" {
                if let imageURLString = bestAttemptContent.userInfo["image"] as? String, let URL = URL(string: imageURLString) {
                    downloadAndSave(url: URL, handler: { (localURL) in
                        if let localURL = localURL {
                            do {
                                let attachment = try UNNotificationAttachment(identifier: "image_downloaded", url: localURL, options: nil)
                                bestAttemptContent.attachments = [attachment]
                            } catch {
                                print(error)
                            }
                        }
                        contentHandler(bestAttemptContent)
                    })
                }
            }
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}

extension FileManager {
    var cacheDirectory: String {
        var paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
}

extension String {
    
    var md5: String {
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        if let data = data(using: .utf8) {
            data.withUnsafeBytes{ (bytes: UnsafePointer<UInt8>) -> Void in
                CC_MD5(bytes, CC_LONG(data.count), &digest)
            }
        }
        var digestHex = ""
        for index in 0..<Int(CC_MD5_DIGEST_LENGTH) {
            digestHex += String(format: "%02x", digest[index])
        }
        return digestHex
    }
    
}


