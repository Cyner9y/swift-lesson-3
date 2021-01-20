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
    
    func friendsGet(completion: @escaping ([Friend]) -> Void) {
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
    func groupsGet() {
        let path = "/method/groups.get"
        let params: Parameters = [
            "extended": 1,
            "access_token": SessionVk.shared.token,
            "v": "5.126"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseJSON { response in
                guard let json = response.value else { return }
                print(json)
            }
    }
    
    func photosGetAll(owner_id: Int) {
        let path = "/method/photos.getAll"
        let params: Parameters = [
            "owner_id": owner_id,
            "access_token": SessionVk.shared.token,
            "v": "5.126"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseJSON { response in
                guard let json = response.value else { return }
                print(json)
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
    
    func groupsGetCatalog(category_id: Int, subcategory_id: Int) {
        let path = "/method/groups.getCatalog"
        let params: Parameters = [
            "category_id": category_id,
            "subcategory_id": subcategory_id,
            "access_token": SessionVk.shared.token,
            "v": "5.126"
        ]
        
        AF.request(baseUrl + path, method: .get, parameters: params)
            .responseJSON { response in
                guard let json = response.value else { return }
                print(json)
            }
    }
}
