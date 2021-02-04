//
//  FriendsVkRealm.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.01.2021.
//

import SwiftyJSON
import RealmSwift

class FriendsVk: Object {
    @objc dynamic var count: Int = 0
    var friends: [JSON] = []
    
    convenience init(json: JSON) {
        self.init()
        self.count = json["count"].intValue
        self.friends = json["items"].arrayValue
    }
}

class FriendVk: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var lastName: String = ""
    @objc dynamic var photo50: String = ""
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case photo50 = "photo_50"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.firstName = json["first_name"].stringValue
        self.id = json["id"].intValue
        self.lastName = json["last_name"].stringValue
        self.photo50 = json["photo_50"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
