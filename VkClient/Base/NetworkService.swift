//
//  NetworkService.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 15.01.2021.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkService {
    
    private let baseUrl = "https://api.vk.com"
    
    enum GroupType: String {
        case group = "group"
        case page = "page"
        case event = "event"
    }
    
    func friendsGet(completion: @escaping ([FriendVk]) -> Void) {
        let path = "/method/friends.get"
        let params: Parameters = [
            "fields": "photo_50",
            "access_token": SessionVk.shared.token,
            "v": "5.126"
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
    
    func groupsGet(completion: @escaping ([MyGroupVk]) -> Void) {
        let path = "/method/groups.get"
        let params: Parameters = [
            "extended": 1,
            "access_token": SessionVk.shared.token,
            "v": "5.126"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(MyGroupsVk.self, from: data)
                    let myGroups = response?.response.items
                    completion(myGroups!)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func photosGetAll(owner_id: Int, completion: @escaping ([PhotoVk]) -> Void) {
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "owner_id": owner_id,
            "access_token": SessionVk.shared.token,
            "v": "5.126"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseData { response in
                switch response.result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let response = try? decoder.decode(PhotosVk.self, from: data)
                    let photos = response?.response.items
                    completion(photos ?? [])
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func groupsSearch(query: String, type: GroupType) {
        let path = "/method/groups.search"
        let params: Parameters = [
            "q": query,
            "type": type,
            "access_token": SessionVk.shared.token,
            "v": "5.126"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseJSON { response in
                guard let json = response.value else { return }
                print(json)
            }
    }
    
    func groupsGetCatalog(completion: @escaping ([GroupVk]) -> Void) {
        let path = "/method/groups.getCatalog"
        let params: Parameters = [
            "access_token": SessionVk.shared.token,
            "v": "5.126"
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
