//
//  PhotosCell.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit

class PhotosCell: UICollectionViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    
    func configure(wih photo: FriendPhotoVk) {
        userPhoto.kf.setImage(with: URL(string: photo.url))
    }
}
