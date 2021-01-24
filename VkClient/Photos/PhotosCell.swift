//
//  PhotosCell.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit

class PhotosCell: UICollectionViewCell {

    @IBOutlet weak var userPhoto: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        userPhoto.image = nil
    }
    
    func congigure(wih photo: PhotoVk) {
        let url = URL(string: photo.sizes.last!.url)
        userPhoto.kf.setImage(with: url)
    }
}
