//
//  LikeControl.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 20.12.2020.
//

import UIKit

@IBDesignable class LikeControl: UIControl {
    
    private var stackView: UIStackView!
    private var likeButton = HeartButton()
    private let likesLabel = UILabel()
    private var likesCount: Int = 9
    private var liked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView() {
        likeButton.isUserInteractionEnabled = false
        likesLabel.text = "\(likesCount)"
        likesLabel.textColor = UIColor.darkGray
        likesLabel.font = .systemFont(ofSize: 20)
        
        stackView = UIStackView(arrangedSubviews: [likeButton, likesLabel])
        self.addSubview(stackView)
        stackView.distribution = .fillEqually
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    func incrementLikesCount() {
        likesCount += 1
        updateLikesCount(likes: likesCount)
    }
    
    func decrementLikesCount() {
        likesCount -= 1
        updateLikesCount(likes: likesCount)
    }
    
    func updateLikesCount(likes: Int) {
        likesCount = likes
        likesLabel.text = "\(likesCount)"
        
    }
    
    func like() {
        if !liked {
            likeButton.liked = true
            likesLabel.textColor = .red
            likeButton.setNeedsDisplay()
            incrementLikesCount()
            liked = true
        } else {
            likeButton.liked = false
            likesLabel.textColor = .gray
            likeButton.setNeedsDisplay()
            decrementLikesCount()
            liked = false
        }
    }
    
    lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        recognizer.numberOfTapsRequired = 1
        recognizer.numberOfTouchesRequired = 1
        return recognizer
    }()
    
    @objc func onTap(_ sender: HeartButton) {
        like()
        animateLikeButton()
    }
    
    func animateLikeButton() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1
        animation.stiffness = 200
        animation.mass = 1
        animation.duration = 1
        animation.beginTime = CACurrentMediaTime()
        animation.fillMode = CAMediaTimingFillMode.backwards
        self.likeButton.layer.add(animation, forKey: nil)
    }
}

@IBDesignable class HeartButton: UIButton {
    
    @IBInspectable var filled: Bool = true
    @IBInspectable var strokeWidth: CGFloat = 2.0
    @IBInspectable var strokeColor: UIColor = UIColor.gray
    
    var liked: Bool = false
    
    override func draw(_ rect: CGRect) {
        let bezierPath = UIBezierPath(heartSize: 25.0)
        
        if !liked {
            strokeColor = UIColor.gray
            self.strokeColor.setStroke()
            self.filled = false
        } else {
            strokeColor = UIColor.red
            self.tintColor = UIColor.red
            self.strokeColor.setStroke()
            self.tintColor.setFill()
            bezierPath.fill()
        }
        bezierPath.lineWidth = self.strokeWidth
        bezierPath.stroke()
    }
}
