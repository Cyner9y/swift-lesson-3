//
//  News.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 24.12.2020.
//

import Foundation

struct News {
    let newsText: String
    let newsImage: String
    let likesCount: Int
    let commentsCount: Int
    let sharesCount: Int
    let viewsCount: Int
}

func generateNews(count: Int) -> [News]? {
    return (1...count).map {_ in generateOneNews()}
}

func generateOneNews() -> News {
    return News(
        newsText: Lorem.paragraph,
        newsImage: "GroupAvatars/\(Int.random(in: 1...5))",
        likesCount: Int.random(in: 1...100),
        commentsCount: Int.random(in: 1...100),
        sharesCount: Int.random(in: 1...100),
        viewsCount: Int.random(in: 1...100))
}
