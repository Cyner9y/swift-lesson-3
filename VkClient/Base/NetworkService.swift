//
//  NetworkService.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 15.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Response: Decodable {
    let response: JSON
}

class NetworkService {
    
    private let baseUrl = "https://api.vk.com"
    private let token = SessionVk.shared.token
    private let version = "5.126"
    
    enum GroupType: String {
        case group = "group"
        case page = "page"
        case event = "event"
    }
    
    func friendsGet(completion: @escaping ([FriendVk]) -> Void) {
        let path = "/method/friends.get"
        let params: Parameters = [
            "fields": "photo_50",
            "access_token": token,
            "v": version
        ]
        
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let responstData = try JSONDecoder().decode(Response.self, from: data)
                let dataFriends = FriendsVk(json: responstData.response)
                
                var friendsArray = [FriendVk]()
                
                for item in dataFriends.friends {
                    let friend = FriendVk(json: item)
                    friendsArray.append(friend)
                }
                completion(friendsArray)
                
            } catch {
                print("error")
            }
        }
    }
    
    func groupsGet(completion: @escaping ([MyGroupVk]) -> Void) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "v" : version
        ]
        
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let responstData = try JSONDecoder().decode(Response.self, from: data)
                let dataGroups = MyGroupsVk(json: responstData.response)
                
                var groupsArray = [MyGroupVk]()
                
                for item in dataGroups.groups {
                    let group = MyGroupVk(json: item)
                    groupsArray.append(group)
                }
                
                completion(groupsArray)
                
            } catch {
                print("error")
            }
        }
    }
    
    func photosGetAll(friendId: Int, completion: @escaping ([FriendPhotoVk]) -> Void) {
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token" : token,
            "owner_id" : friendId,
            "v" : version
        ]
        
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let responstData = try JSONDecoder().decode(Response.self, from: data)
                let dataPhotos = FriendPhotosVk(json: responstData.response)
                
                var photoArray = [FriendPhotoVk]()
                
                for item in dataPhotos.friendsPhoto {
                    let friendPhoto = FriendPhotoVk(json: item)
                    photoArray.append(friendPhoto)
                }
                completion(photoArray)
                
            } catch {
                print("error")
            }
        }
    }
    
    func groupsGetCatalog(completion: @escaping ([GroupVk]) -> Void) {
        let path = "/method/groups.getCatalog"
        let params: Parameters = [
            "access_token": token,
            "v": version
        ]
        
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { response in
            guard let data = response.data else { return }
            
            do {
                let responstData = try JSONDecoder().decode(Response.self, from: data)
                let dataGroups = GroupsVk(json: responstData.response)
                
                var groupsArray = [GroupVk]()
                
                for item in dataGroups.groups {
                    let group = GroupVk(json: item)
                    groupsArray.append(group)
                }
                
                completion(groupsArray)
                
            } catch {
                print("error")
            }
        }
    }
}
