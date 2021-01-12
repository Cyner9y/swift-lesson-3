//
//  NewsCell.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 24.12.2020.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var likes: LikeControl!
    @IBOutlet weak var comments: CommentControl!
    @IBOutlet weak var shares: ShareControl!
    @IBOutlet weak var views: ViewsControl!
    
    override func awakeFromNib() {
          super.awakeFromNib()
      }
}
