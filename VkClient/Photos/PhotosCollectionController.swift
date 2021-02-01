//
//  PhotosCollectionController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 13.12.2020.
//

import UIKit
import Kingfisher
import RealmSwift

private let reuseIdentifier = "Cell"

class PhotosCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var id: Int = 0
    var photosVk: Results<PhotoVkRealm>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let networkService = NetworkService()
        networkService.photosGetAll(ownerId: id) { photos in
            try? RealmService.save(items: photos)
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosVk?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath)
                as? PhotosCell
        else { return UICollectionViewCell() }
        guard let photo = photosVk?[indexPath.row] else { return cell }
        cell.configure(wih: photo)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: width)
    }
}
