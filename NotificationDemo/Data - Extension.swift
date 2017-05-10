//
//  Data - Extension.swift
//  NotificationDemo
//
//  Created by user on 2017/5/9.
//  Copyright © 2017年 user. All rights reserved.
//

import Foundation

extension Data {
    var hexString: String {
        return withUnsafeBytes { (bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map{String(format: "%02hhx", $0)}.reduce("", {$0 + $1})
        }
    }
}
