//
//  FriendCell.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 12.12.2020.
//

import UIKit

class FriendCell: UITableViewCell {
    
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImage: UIImageView!
    
    @IBOutlet weak var shadow: ShadowViewController!
    
    func configure(with friendVk: FriendVk) {
        friendName.text = "\(friendVk.firstName) \(friendVk.lastName)"
        let url = URL(string: friendVk.photo50)
        friendImage.kf.setImage(with: url)
        friendImage.layer.masksToBounds = false
        friendImage.layer.cornerRadius = friendImage.frame.width/2
        friendImage.clipsToBounds = true
    }
    
//    func animate() {
//        let animation = CASpringAnimation(keyPath: "transform.scale")
//        animation.fromValue = 0
//        animation.toValue = 1
//        animation.stiffness = 100
//        animation.mass = 1
//        animation.duration = 1
//        animation.beginTime = CACurrentMediaTime()
//        animation.fillMode = CAMediaTimingFillMode.backwards
//        friendImage.layer.add(animation, forKey: nil)
//        shadow.layer.add(animation, forKey: nil)
//    }
}
