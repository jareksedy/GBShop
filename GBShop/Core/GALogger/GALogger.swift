//
//  GALogger.swift
//  GBShop
//
//  Created by Ярослав on 22.01.2022.
//

import Foundation
import Firebase

class GALogger {
    class func logEvent(name: String, key: String, value: String) {
        Analytics.logEvent(name, parameters: [key: value])
    }
}
