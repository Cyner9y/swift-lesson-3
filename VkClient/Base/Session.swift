//
//  Session.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.01.2021.
//

import Foundation

class SessionVK {
    
    private init() {}
    
    public static let shared = Session()
    
    var token = ""
    var userId = 0
}
