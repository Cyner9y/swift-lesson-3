//
//  NewsTableController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 24.12.2020.
//

import UIKit

class NewsTableController: UITableViewController {

    var newsToDisplay: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NewsCell", bundle: nil),
                           forCellReuseIdentifier: "NewsCell")
        if let news = generateNews(count: 5) {
          newsToDisplay = news
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsToDisplay.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath)
                as? NewsCell
        else { return UITableViewCell() }
        
        cell.newsLabel.text = newsToDisplay[indexPath.row].newsText
        cell.newsImage.image = UIImage(named: newsToDisplay[indexPath.row].newsImage)
        cell.likes.updateLikesCount(likes: newsToDisplay[indexPath.row].likesCount)
        cell.comments.updateCommentsCount(comments: newsToDisplay[indexPath.row].commentsCount)
        cell.shares.updateSharesCount(comments: newsToDisplay[indexPath.row].sharesCount)
        cell.views.updateViewsCount(comments: newsToDisplay[indexPath.row].viewsCount)
        
        return cell
    }
}
