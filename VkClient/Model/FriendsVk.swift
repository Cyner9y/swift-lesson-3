//
//  FriendsVK.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 19.01.2021.
//

import Foundation
import SwiftyJSON

struct FriendsVk: Codable {
    let response: FriendsResponse
}

struct FriendsResponse: Codable {
    let count: Int
    let items: [FriendVk]
}

struct FriendVk: Codable {
    let firstName: String
    let id: Int
    let lastName: String
    let canAccessClosed, isClosed: Bool?
    let photo50: String
    let lists: [Int]?
    let trackCode: String
    let deactivated: Deactivated?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case id
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case photo50 = "photo_50"
        case lists
        case trackCode = "track_code"
        case deactivated
    }
}

enum Deactivated: String, Codable {
    case banned = "banned"
    case deleted = "deleted"
}

func sortFriends(_ friends: [FriendVk]) -> (characters: [Character], sortedFriends: [Character: [FriendVk]]) {
    var characters = [Character]()
    var sortedFriends = [Character: [FriendVk]]()
    
    friends.forEach { friend in
        guard let character = friend.lastName.first else { return }
        if var thisCharFriends = sortedFriends[character] {
            thisCharFriends.append(friend)
            sortedFriends[character] = thisCharFriends
        } else {
            sortedFriends[character] = [friend]
            characters.append(character)
        }
    }
    characters.sort()
    return (characters, sortedFriends)
}
