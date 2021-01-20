//
//  MyGroups.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 20.01.2021.
//

import Foundation

struct MyGroupsVk: Codable {
    let response: MyGroupsResponse
}

struct MyGroupsResponse: Codable {
    let count: Int
    let items: [MyGroupVk]
}

struct MyGroupVk: Codable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: GroupsTypeEnum
    let isAdmin: Int
    let adminLevel: Int?
    let isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String
    let deactivated: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case adminLevel = "admin_level"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
        case deactivated
    }
}
