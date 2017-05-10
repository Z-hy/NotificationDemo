//
//  UIAlertViewController - Extension.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func showConfirmAlert(_ message: String, in viewController: UIViewController) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    static func showConfirmAlertFromTopViewController(_ message: String) {
        if let vc = UIApplication.shared.keyWindow?.rootViewController {
            showConfirmAlert(message, in: vc)
        }
    }
    
}
