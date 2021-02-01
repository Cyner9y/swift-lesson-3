//
//  GroupCell.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit

class GroupCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupAvatar: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        groupName.text = nil
        groupAvatar.image = nil
    }
    
    func configureMyGroup(with groupVk: MyGroupVkRealm) {
        groupName.text = groupVk.name
        let url = URL(string: groupVk.photo50)
        groupAvatar.kf.setImage(with: url)
        groupAvatar.layer.cornerRadius = groupAvatar.frame.height / 2
        groupAvatar.clipsToBounds = true
    }
    
    func configureAllGroup(with groupVk: GroupVk) {
        groupName.text = groupVk.name
        let url = URL(string: groupVk.photo50)
        groupAvatar.kf.setImage(with: url)
        groupAvatar.layer.cornerRadius = groupAvatar.frame.height / 2
        groupAvatar.clipsToBounds = true
    }
    
}
