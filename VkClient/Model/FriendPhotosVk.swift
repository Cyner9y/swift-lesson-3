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
        self.count = json["count"].intValue
        self.friendsPhoto = json["items"].arrayValue
    }
}

class FriendPhotoVk: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var photo_75: String = ""
    @objc dynamic var photo_130: String = ""
    @objc dynamic var photo_604: String = ""
    @objc dynamic var photo_807: String = ""
    @objc dynamic var photo_1280: String = ""
    @objc dynamic var photo_2560: String = ""
    @objc dynamic var width: Int = 0
    @objc dynamic var height: Int = 0
    @objc dynamic var date: Int = 0
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.photo_75 = json["photo_75"].stringValue
        self.photo_130 = json["photo_130"].stringValue
        self.photo_604 = json["photo_604"].stringValue
        self.photo_807 = json["photo_807"].stringValue
        self.photo_1280 = json["photo_1280"].stringValue
        self.photo_2560 = json["photo_2560"].stringValue
        self.width = json["width"].intValue
        self.height = json["height"].intValue
        self.date = json["date"].intValue
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
