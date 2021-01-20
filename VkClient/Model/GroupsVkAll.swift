//
//  GroupsVk.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 20.01.2021.
//

import Foundation

import Foundation

struct GroupsVk: Codable {
    let response: GroupsVkResponse
}

struct GroupsVkResponse: Codable {
    let count: Int
    let items: [GroupVk]
}

struct GroupVk: Codable, Equatable {
    let id: Int
    let name, screenName: String
    let isClosed: Int
    let type: GroupsTypeEnum
    let isAdmin, isMember, isAdvertiser: Int
    let photo50, photo100, photo200: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case isAdmin = "is_admin"
        case isMember = "is_member"
        case isAdvertiser = "is_advertiser"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
}

enum GroupsTypeEnum: String, Codable {
    case event = "event"
    case group = "group"
    case page = "page"
}
