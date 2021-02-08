//
//  GroupsTableController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit
import RealmSwift
import Firebase
import FirebaseDatabase

class GroupsTableController: UITableViewController {
    
    @IBOutlet var groupsTableView: UITableView!
    
    private lazy var groupsVk = try? Realm().objects(MyGroupVk.self)
    private var tokenNotificationsGroups: NotificationToken?
    
    var citiesRef: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        compareAndUpdate()
        let networkService = NetworkService()
        networkService.groupsGet() { [weak self] myGroups in
            try? RealmService.save(items: myGroups)
        }
                
        let zipcode = Int.random(in: 10000...99999)
        let city = FirebaseCity(name: "Moscow", zipcode: zipcode)
        
        let cityRef = self.citiesRef.child("Moscow".lowercased())
        cityRef.setValue(city.toAnyObject())
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsVk?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
                as? GroupCell
        else { return UITableViewCell() }
        
        cell.configureMyGroup(with: (groupsVk?[indexPath.row])!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func compareAndUpdate() {
        guard let realm = try? Realm() else { return }
        groupsVk = realm.objects(MyGroupVk.self)
        
        self.tokenNotificationsGroups = groupsVk?.observe { [weak self] (changes: RealmCollectionChange) in
            switch changes {
            case .initial:
                self?.groupsTableView.reloadData()
            case .update(_, let deletions, let insertions, let modifications):
                self?.groupsTableView.beginUpdates()
                self?.groupsTableView.insertRows(at: insertions.map ( {IndexPath(row: $0, section: 0)} ),
                                                     with: .automatic)
                self?.groupsTableView.deleteRows(at: deletions.map ( {IndexPath(row: $0, section: 0)} ),
                                                     with: .automatic)
                self?.groupsTableView.reloadRows(at: modifications.map( {IndexPath(row: $0, section: 0)} ),
                                                     with: .automatic)
                self?.groupsTableView.endUpdates()
            case .error(let error):
                print(error)
            }
        }
    }
}
