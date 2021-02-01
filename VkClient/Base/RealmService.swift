//
//  RealmService.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 31.01.2021.
//

import RealmSwift

class RealmService {
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: false)
    
    static func save <T: Object>(items: [T],
                                 configuration: Realm.Configuration = deleteIfMigration,
                                 update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write{
            realm.add(items, update: update)
        }
    }
}
