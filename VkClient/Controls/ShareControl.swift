//
//  ShareControl.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 24.12.2020.
//

import UIKit

import UIKit

@IBDesignable class ShareControl: UIControl {
    private var stackView: UIStackView!
    private var shareIcon = UIImage(named: "shareIcon.png")
    private var shareIconView = UIImageView()
    private let sharesLabel = UILabel()
    private var sharesCount: Int = 7
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        shareIconView.image = shareIcon
        shareIconView.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        sharesLabel.text = "\(sharesCount)"
        sharesLabel.textColor = UIColor.darkGray
        setupConstraints()
        
        stackView = UIStackView(arrangedSubviews: [shareIconView, sharesLabel])
        
        self.addSubview(stackView)
        stackView.distribution = .fillEqually
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func setupConstraints() {
        sharesLabel.heightAnchor.constraint(equalTo: shareIconView.heightAnchor, multiplier: 1)
    }
    
    func incrementSharesCount() {
        sharesCount += 1
        updateSharesCount(comments: sharesCount)
    }
    
    func decrementSharesCount() {
        sharesCount -= 1
        updateSharesCount(comments: sharesCount)
    }
    
    func updateSharesCount(comments: Int) {
        sharesCount = comments
        sharesLabel.text = "\(sharesCount)"
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self,
                                                action: #selector(onTap(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap(_ sender: UIStackView) {
        incrementSharesCount()
    }
}
