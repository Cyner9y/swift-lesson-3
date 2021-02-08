//
//  FirebaseModel.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 07.02.2021.
//

import Firebase

struct FirebaseCity {
    let name: String
    let zipcode: Int
    
    let ref: DatabaseReference?
    
    init(name: String, zipcode: Int) {
        self.name = name
        self.zipcode = zipcode
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard let value = snapshot.value as? [String: Any],
              let name = value["name"] as? String,
              let zipcode = value["zipcode"] as? Int
        else{ return nil }
        self.name = name
        self.zipcode = zipcode
        self.ref = snapshot.ref
    }
    
    func toAnyObject() -> [String: Any] {
        [
            "name": name,
            "zipcode": zipcode,
        ]
    }
}
