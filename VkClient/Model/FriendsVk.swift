//
//  FriendsVK.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 19.01.2021.
//

import Foundation

struct FriendsVk: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [Item]
}

struct Item: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let canAccessClosed, isClosed: Bool?
    let nickname: String?
    let lists: [Int]?
    let trackCode: String
    let deactivated: Deactivated?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case nickname, lists
        case trackCode = "track_code"
        case deactivated
    }
}

enum Deactivated: String, Codable {
    case banned = "banned"
    case deleted = "deleted"
}