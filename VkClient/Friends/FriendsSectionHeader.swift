//
//  FriendsSectionHeader.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 22.12.2020.
//

import UIKit

class FriendsSectionHeader: UITableViewHeaderFooterView {
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = ""
        detailTextLabel?.text = ""
    }
}
