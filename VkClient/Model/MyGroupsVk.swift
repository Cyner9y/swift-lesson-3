//
//  MyGroupsVkRealm.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.01.2021.
//

import SwiftyJSON
import RealmSwift

class MyGroupsVk {
    @objc dynamic var count: Int = 0
    var groups: [JSON] =  []
    
    convenience init(json: JSON) {
        self.init()
        self.count = json["count"].intValue
        self.groups = json["items"].arrayValue
    }
}

class MyGroupVk: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var isClosed: Int = 0
    @objc dynamic var photo50: String = ""
    @objc dynamic var photo100: String = ""
    @objc dynamic var photo200: String = ""
    
    
    enum CodingKeys: String, CodingKey {
        case isClosed = "is_closed"
        case photo50 = "photo_50"
        case photo100 = "photo_100"
        case photo200 = "photo_200"
    }
    
    convenience init(json: JSON) {
        self.init()
        self.id = json["id"].intValue
        self.isClosed = json["is_closed"].intValue
        self.name = json["name"].stringValue
        self.photo50 = json["photo_50"].stringValue
        self.photo100 = json["photo_100"].stringValue
        self.photo200 = json["photo_200"].stringValue
        
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
