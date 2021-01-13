//
//  Session.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.01.2021.
//

import Foundation

class Session {
    
    private init() {}
    
    public static let shared = Session()
    
    var token = ""
    var userId = ""
}
