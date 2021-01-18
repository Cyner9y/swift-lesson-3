//
//  AllGroupsTableController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit

class AllGroupsTableController: UITableViewController {
    
    var allGroups = generateGroups(count: 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        networkService.groupsGetCatalog(category_id: 0, subcategory_id: 0)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
                as? GroupCell
        else { return UITableViewCell() }
        cell.groupName.text = allGroups[indexPath.row].name
        cell.groupAvatar.image = UIImage(named: "GroupAvatars/\(allGroups[indexPath.row].avatar)")
        cell.groupAvatar.layer.cornerRadius = cell.groupAvatar.frame.height / 2
        cell.groupAvatar.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
