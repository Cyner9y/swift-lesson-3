//
//  CommentControl.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 24.12.2020.
//

import UIKit

@IBDesignable class CommentControl: UIControl {
    
    private var stackView: UIStackView!
    private var commentIcon = UIImage(named: "commentIcon.png")
    private var commentIconView = UIImageView()
    private let commentsLabel = UILabel()
    private var commentsCount: Int = 8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        commentIconView.image = commentIcon
        commentIconView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        commentsLabel.text = "\(commentsCount)"
        commentsLabel.textColor = UIColor.darkGray
        setupConstraints()
        
        stackView = UIStackView(arrangedSubviews: [commentIconView, commentsLabel])
        
        self.addSubview(stackView)
        stackView.distribution = .fillEqually
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func setupConstraints() {
        commentsLabel.heightAnchor.constraint(equalTo: commentIconView.heightAnchor, multiplier: 1)
    }
    
    func incrementCommentsCount() {
        commentsCount += 1
        updateCommentsCount(comments: commentsCount)
    }
    
    func decrementCommentsCount() {
        commentsCount -= 1
        updateCommentsCount(comments: commentsCount)
    }
    
    func updateCommentsCount(comments: Int) {
        commentsCount = comments
        commentsLabel.text = "\(commentsCount)"
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap(_ sender: UIStackView) {
        incrementCommentsCount()
    }
}
