//
//  PhotosVkRealm.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.01.2021.
//

import SwiftyJSON
import RealmSwift

class FriendPhotosVk: Object {
    @objc dynamic var count: Int = 0
    var friendsPhoto: [JSON] = []
    
    convenience init(json: JSON) {
        self.init()
        if let count = json["count"].int {
            self.count = count
        }
        if let friendsPhoto = json["items"].array {
            self.friendsPhoto = friendsPhoto
        }
    }
}

class FriendPhotoVk: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var url: String = ""
        
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.url = json["sizes"][2]["url"].stringValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
