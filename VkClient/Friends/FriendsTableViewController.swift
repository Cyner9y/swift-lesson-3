//
//  FriendsTableViewController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 12.12.2020.
//

import UIKit
import RealmSwift

class FriendsTableViewController: UITableViewController, UISearchBarDelegate {
    
    private lazy var friendsVk = try? Realm().objects(FriendVk.self).toArray(type: FriendVk.self) as [FriendVk]
    
    var firstLetters = [Character]()
    var sortedFriends = [Character: [FriendVk]]() {
        didSet {
            tableView.reloadData()
        }
    }
    var searchActive = false
    var filteredFriendsArray: [FriendVk] = [] {
        didSet {
            updateFriendsIndex(friends: filteredFriendsArray)
            updateFriendsNamesDictionary(friends: filteredFriendsArray)
        }
    }
    
    @IBOutlet weak var friendsSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(FriendsSectionHeader.self, forHeaderFooterViewReuseIdentifier: "FriendsSectionHeader")
        
        tableView.keyboardDismissMode = .onDrag
        
        let networkService = NetworkService()
        networkService.friendsGet() { [weak self] friends in
            try? RealmService.save(items: friends)
        }
        
        (firstLetters, sortedFriends) = sortFriends(friendsVk ?? [])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let destination = segue.destination as? PhotosCollectionController,
            let indexPath = tableView.indexPathForSelectedRow
        else { return }
        
        let char = firstLetters[indexPath.section]
        
        if let selectedFriend = sortedFriends[char]?[indexPath.row] {
            destination.friendsId = selectedFriend.id
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
            cell.configure(with: friends[indexPath.row])
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
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
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
        filteredFriendsArray = friendsVk!.filter({ (friend) -> Bool in
            FirstLetterSearch.isMatched(searchBase: "\(friend.firstName) \(friend.lastName)", searchString: searchText)
        })
        updateFriendsIndex(friends: filteredFriendsArray)
        updateFriendsNamesDictionary(friends: filteredFriendsArray)
        print(filteredFriendsArray)
        
        if (searchText.count == 0) {
            updateFriendsIndex(friends: friendsVk ?? [])
            updateFriendsNamesDictionary(friends: friendsVk ?? [])
            searchActive = false
            hideKeyboard()
        }
        tableView.reloadData()
    }
    
    @objc func hideKeyboard() {
        searchActive = false
        friendsSearchBar.endEditing(true)
    }
    
    func updateFriendsNamesDictionary(friends: [FriendVk]) {
        sortedFriends = SectionIndexManager.getFriendIndexDictionary(array: friends)
    }
    
    func updateFriendsIndex(friends: [FriendVk]) {
        firstLetters = SectionIndexManager.getOrderedIndexArray(array: friends)
    }
    
    func sortFriends(_ friends: [FriendVk]) -> (characters: [Character], sortedFriends: [Character: [FriendVk]]) {
        var characters = [Character]()
        var sortedFriends = [Character: [FriendVk]]()
        
        friends.forEach { friend in
            guard let character = friend.lastName.first else { return }
            if var thisCharFriends = sortedFriends[character] {
                thisCharFriends.append(friend)
                sortedFriends[character] = thisCharFriends
            } else {
                sortedFriends[character] = [friend]
                characters.append(character)
            }
        }
        characters.sort()
        return (characters, sortedFriends)
    }
}
