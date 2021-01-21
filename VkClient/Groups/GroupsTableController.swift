//
//  GroupsTableController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit
import Kingfisher

class GroupsTableController: UITableViewController {
    
    var groupsVk = [MyGroupVk]()

//    @IBAction func addGroup(segue: UIStoryboardSegue) {
//        guard
//            segue.identifier == "addGroup",
//            let controller = segue.source as? AllGroupsTableController,
//            let indexPath = controller.tableView.indexPathForSelectedRow,
//            !groupsVk.contains(controller.groupsVk[indexPath.row])
//        else { return }
//        let group = controller.groupsVk[indexPath.row]
//        groupsVk.append(group)
//        tableView.reloadData()
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        networkService.groupsGet() { [weak self] myGroups in
            self?.groupsVk = myGroups
            self?.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            groupsVk.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }

    // MARK: - Table view data source

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
