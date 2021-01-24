//
//  Session.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.01.2021.
//

import Foundation

class SessionVk {
    
    private init() {}
    
    public static let shared = SessionVk()
    
    var token = ""
    var userId = 0
}
