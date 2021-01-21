//
//  PhotosCollectionController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit
import Kingfisher

private let reuseIdentifier = "Cell"

class PhotosCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var id: Int = 0
    var photosVk = [PhotoVk]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        networkService.photosGetAll(owner_id: id) { photos in
            self.photosVk = photos
            self.collectionView.reloadData()
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosVk.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath)
                as? PhotosCell
        else { return UICollectionViewCell() }
        
        let url = URL(string: photosVk[indexPath.row].sizes.last!.url)
        cell.photo.kf.setImage(with: url)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: width)
    }
}
