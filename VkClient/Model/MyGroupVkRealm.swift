//
//  MyGroupsVkRealm.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.01.2021.
//

import Foundation
import RealmSwift

class MyGroupVkRealm: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var screenName = ""
    @objc dynamic var isClosed = 0
    @objc dynamic var type = ""
    @objc dynamic var isAdmin = 0
    let adminLevel = RealmOptional<Int>()
    @objc dynamic var isMember = 0
    @objc dynamic var varisAdvertiser = 0
    @objc dynamic var photo50 = ""
    @objc dynamic var photo100 = ""
    @objc dynamic var photo200 = ""
    @objc dynamic var deactivated: String? = nil

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
    
    convenience init(id: Int,
                     name: String,
                     screenName: String,
                     isClosed: Int,
                     type: String,
                     isAdmin: Int,
                     isMember: Int,
                     varisAdvertiser: Int,
                     photo50: String,
                     photo100: String,
                     photo200: String,
                     deactivated: String) {
        self.init()
        self.id = id
        self.name = name
        self.screenName = screenName
        self.isClosed = isClosed
        self.type = type
        self.isAdmin = isAdmin
        self.isMember = isMember
        self.varisAdvertiser = varisAdvertiser
        self.photo50 = photo50
        self.photo100 = photo100
        self.photo200 = photo200
        self.deactivated = deactivated
    }
}
