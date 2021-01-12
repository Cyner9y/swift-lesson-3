//
//  User.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import Foundation

struct User {
    let firstName: String
    let lastName: String
    let avatar: String
    let photos: [String]
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

func generateUser() -> User{
    return User(firstName: Lorem.firstName,
                lastName: Lorem.lastName,
                avatar: String(Int.random(in: 1...5)),
                //photos: (1...5).map {_ in String(Int.random(in: 1...5))})
                photos: ["1"])
}

func generateUsers(count: Int) -> [User] {
    return (1...count).map {_ in generateUser()}
}

func sortFriends(_ friends: [User]) -> (characters: [Character], sortedFriends: [Character: [User]]) {
    var characters = [Character]()
    var sortedFriends = [Character: [User]]()
    
    friends.forEach { friend in
        guard let character = friend.lastName.first else { return }
        if var thisCharFriends = sortedFriends[character] {
            thisCharFriends.append(friend)
            sortedFriends[character] = thisCharFriends
        } else {
            sortedFriends[character] = [friend]
            characters.append(character)
        }
    }
    characters.sort()
    return (characters, sortedFriends)
}
