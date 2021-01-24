//
//  PhotosVk.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 21.01.2021.
//

import Foundation

struct PhotosVk: Codable {
    let response: PhotosVkResponse
}

struct PhotosVkResponse: Codable {
    let count: Int
    let items: [PhotoVk]
}

struct PhotoVk: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let sizes: [Size]
    let text: String
    let postID: Int?

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case sizes, text
        case postID = "post_id"
    }
}

struct Size: Codable {
    let height: Int
    let url: String
    let type: PhotoTypeEnum
    let width: Int
}

enum PhotoTypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}
