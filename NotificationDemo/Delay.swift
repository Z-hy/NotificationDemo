//
//  Delay.swift
//  NotificationDemo
//
//  Created by user on 2017/5/10.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

func delay(_ timeInterval: TimeInterval, _ block: @escaping () -> Void) {
    let after = DispatchTime.now() + timeInterval
    DispatchQueue.main.asyncAfter(deadline: after, execute: block)
}
