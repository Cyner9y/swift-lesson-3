//
//  SectionIndexManager.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 22.12.2020.
//

import Foundation

class SectionIndexManager {
  
  static func getOrderedIndexArray(array: [FriendVk]) -> [Character] {
    var indexArray: [Character] = []
    var indexSet = Set<Character>()
    for item in array {
        let firstLetter = item.firstName[0]
      indexSet.insert(firstLetter)
    }
    for char in indexSet{
      indexArray.append(char)
    }
    indexArray.sort()
    return indexArray
  }
  
  static func getFriendIndexDictionary(array: [FriendVk]) -> [Character: [FriendVk]] {
    var friendIndexDictionary: [Character: [FriendVk]] = [:]
    
    for item in array {
        let firstLetter = item.firstName[0]
     if (friendIndexDictionary.keys.contains(firstLetter)) {
         friendIndexDictionary[firstLetter]?.append(item)
     } else {
      friendIndexDictionary[firstLetter] = [item]
      }
    }
    return friendIndexDictionary
  }
}
