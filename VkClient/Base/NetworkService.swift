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
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(FriendsVk.self, from: data)
                    let friends = response?.response.items
                    completion(friends!)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func groupsGet(completion: @escaping ([MyGroupsVkRealm]) -> Void) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "access_token" : token,
            "extended" : 1,
            "v" : version]
        
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { responds in
            guard let data = responds.data else { return }
            
            do {
                let responstData = try JSONDecoder().decode(Response.self, from: data)
                let dataGroups = MyGroupsVkRealm(json: responstData.response)
                
                var groupsArray = [MyGroupsVkRealm]()
                
                for item in dataGroups.groups {
                    let group = MyGroupsVkRealm(json: item)
                    groupsArray.append(group)
                }
                completion(groupsArray)
            } catch {
                print("error")
            }
        }
    }
    
    
    func photosGetAll(ownerId: Int, completion: @escaping ([PhotoVkRealm]) -> Void) {
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "access_token" : token,
            "owner_id" : ownerId,
            "v" : version
        ]
        
        AF.request(baseUrl+path, method: .get, parameters: params).responseJSON { responds in
            guard let data = responds.data else { return }
            
            do {
                let responstData = try JSONDecoder().decode(Response.self, from: data)
                let dataFriends = PhotosVkRealm(json: responstData.response)
                var photos = [PhotoVkRealm]()
                for item in dataFriends.photos {
                    let photo = PhotoVkRealm(json: item)
                    photos.append(photo)
                }
                completion(photos)
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
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(GroupsVk.self, from: data)
                    let groups = response?.response.items
                    completion(groups!)
                case .failure(let error):
                    print(error)
                }
            }
    }
}
