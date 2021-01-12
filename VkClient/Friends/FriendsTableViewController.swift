//
//  FriendsTableViewController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 12.12.2020.
//

import UIKit

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    var myFriends = generateUsers(count: 100)
    var firstLetters = [Character]()
    var sortedFriends = [Character: [User]]()
    var searchActive = false
    var filteredFriendsArray: [User] = []
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")        
        filteredFriendsArray = myFriends
        updateFriendsIndex(friends: filteredFriendsArray)
        updateFriendsNamesDictionary(friends: filteredFriendsArray)
        tableView.keyboardDismissMode = .onDrag

        (firstLetters, sortedFriends) = sortFriends(myFriends)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? PhotosCollectionController,
            let indexPath = tableView.indexPathForSelectedRow
        else { return }
        
        let char = firstLetters[indexPath.section]
        
        if let selectedFriend = sortedFriends[char]?[indexPath.row] {
            destination.avatar = selectedFriend.avatar
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        firstLetters.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let charFriends = firstLetters[section]
        return sortedFriends[charFriends]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
                as? FriendCell
        else { return UITableViewCell() }
        
        let firstLetter = firstLetters[indexPath.section]
        if let friends = sortedFriends[firstLetter] {
            cell.friendName.text = friends[indexPath.row].fullName
            cell.friendImage.setImage(UIImage(named: "Avatars/\(friends[indexPath.row].avatar)"), for: .normal)
            cell.friendImage.imageView?.image = UIImage(named: "Avatars/\(friends[indexPath.row].avatar)")
            cell.friendImage.layer.masksToBounds = false
            cell.friendImage.layer.cornerRadius = cell.friendImage.frame.width/2
            cell.friendImage.clipsToBounds = true
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FriendsSectionHeader")
                as? FriendsSectionHeader
        else { return nil }
        sectionHeader.backgroundView?.backgroundColor = tableView.backgroundColor
        sectionHeader.backgroundView?.alpha = 0.5
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        String(firstLetters[section])
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard !searchActive else { return nil }
        let friendsIndexToStringArray = firstLetters.map { String($0) }
        return friendsIndexToStringArray
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        if let header: UITableViewHeaderFooterView = view as? UITableViewHeaderFooterView {
            header.backgroundView?.backgroundColor = tableView.backgroundColor
            header.backgroundView?.alpha = 0.5
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        hideKeyboard()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredFriendsArray = myFriends.filter({ (friend) -> Bool in
            FirstLetterSearch.isMatched(searchBase: friend.fullName, searchString: searchText)
        })
        updateFriendsIndex(friends: filteredFriendsArray)
        updateFriendsNamesDictionary(friends: filteredFriendsArray)
        print(filteredFriendsArray)
        
        
        if (searchText.count == 0) {
            updateFriendsIndex(friends: myFriends)
            updateFriendsNamesDictionary(friends: myFriends)
            searchActive = false
            hideKeyboard()
        }
        tableView.reloadData()
    }
    
    @objc func hideKeyboard() {
        searchActive = false
        friendsSearchBar.endEditing(true)
    }
    
    func updateFriendsNamesDictionary(friends: [User]) {
        sortedFriends = SectionIndexManager.getFriendIndexDictionary(array: friends)
    }
    
    func updateFriendsIndex(friends: [User]) {
        firstLetters = SectionIndexManager.getOrderedIndexArray(array: friends)
    }
}
