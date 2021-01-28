//
//  FriendsVkRealm.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.01.2021.
//

import Foundation
import RealmSwift

class FriendVkRealm: Object {
    @objc dynamic var firstName = ""
    @objc dynamic var id = 0
    @objc dynamic var lastName = ""
    let canAccessClosed = RealmOptional<Bool>()
    let isClosed = RealmOptional<Bool>()
    @objc dynamic var photo50 = ""
    @objc dynamic var trackCode = ""
    @objc dynamic var deactivated: String? = nil
    
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
    
    convenience init(firstName: String,
                     id: Int,
                     lastName: String,
                     photo50: String,
                     trackCode: String,
                     deactivated: String?) {
        self.init()
        self.firstName = firstName
        self.id = id
        self.lastName = lastName
        self.photo50 = photo50
        self.trackCode = trackCode
        self.deactivated = deactivated
    }
}
