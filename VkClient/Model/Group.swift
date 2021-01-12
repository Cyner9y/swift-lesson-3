//
//  Group.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import Foundation

struct Group: Equatable  {
    let name: String
    let avatar: String
}

func generateGroup() -> Group{
    return Group(name: Lorem.title,
                 avatar: String(Int.random(in: 1...5)))
}

func generateGroups(count: Int) -> [Group] {
    return (1...count).map {_ in generateGroup()}
}
