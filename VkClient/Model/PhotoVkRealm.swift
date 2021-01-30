//
//  PhotosVkRealm.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.01.2021.
//

import Foundation
import RealmSwift

class PhotoVkRealm: Object {
    @objc dynamic var albumID = 0
    @objc dynamic var date = 0
    @objc dynamic var id = 0
    @objc dynamic var ownerID = 0
    @objc dynamic var hasTags = false
    let sizes = List<SizeRealm>()
    @objc dynamic var text = ""
    let postID = RealmOptional<Int>()

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
        case postID = "post_id"
    }
    
    convenience init(albumID: Int,
                     date: Int,
                     id: Int,
                     ownerID: Int,
                     hasTags: Bool,
                     sizes: List<SizeRealm>,
                     text: String) {
        self.init()
        self.albumID = albumID
        self.date = date
        self.id = id
        self.ownerID = ownerID
        self.hasTags = hasTags
        self.text = text
    }
}

class SizeRealm: Object {
    @objc dynamic var height = 0
    @objc dynamic var url = ""
    @objc dynamic var type = ""
    @objc dynamic var width = 0
    
    convenience init(height: Int,
                     url: String,
                     type: String,
                     width: Int) {
        self.init()
        self.height = height
        self.url = url
        self.type = type
        self.width = width
    }
}
