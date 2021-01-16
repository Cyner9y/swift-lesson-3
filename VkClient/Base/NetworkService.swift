//
//  NetworkService.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 15.01.2021.
//

import Foundation
import Alamofire

class NetworkService {
    
    private let host = "https://api.openweathermap.org"
    
    static let session: Session = {
        let session = URLSessionConfiguration()
        session.timeoutIntervalForRequest = 60
        let afSession = Session(configuration: session)
        return afSession
    }()
    
    func weatherRequest() {
        let path = "/data/2.5/forecast"
        let parameters: Parameters = [
            "q": "London",
            "appid": "1b409196acfcec7450381f93344d3434",
            "units": "metric"
        ]
        
        AF.request(host + path,
                   method: .get,
                   parameters: parameters)
            .responseJSON { json in
                print(json)
            }
    }
    
    func sendRequest(for city: String) {
        let urlComponents: URLComponents = {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.openweathermap.org"
            components.path = "/data/2.5/forecast"
            components.queryItems = [
                URLQueryItem(name: "q", value: city),
                URLQueryItem(name: "appid", value: "1b409196acfcec7450381f93344d3434"),
                URLQueryItem(name: "units", value: "metric")
            ]
            return components
        }()
        
        guard let url = urlComponents.url else { fatalError("Url error") }
        var  request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allowsCellularAccess = false
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else { return }
            let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print(json)
        }
        session.resume()
    }
}
