//
//  AllGroupsTableController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit

class AllGroupsTableController: UITableViewController {
    
    var groupsVk = [GroupVk]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        networkService.groupsGetCatalog() { [weak self] groups in
            self?.groupsVk = groups
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsVk.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath)
                as? GroupCell
        else { return UITableViewCell() }
        cell.groupName.text = groupsVk[indexPath.row].name
        let url = URL(string: groupsVk[indexPath.row].photo50)
        cell.groupAvatar.kf.setImage(with: url)
        cell.groupAvatar.layer.cornerRadius = cell.groupAvatar.frame.height / 2
        cell.groupAvatar.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
