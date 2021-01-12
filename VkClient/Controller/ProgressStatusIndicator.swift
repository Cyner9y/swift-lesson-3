//
//  ProgressStatusIndicator.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 27.12.2020.
//

import UIKit

class ProgressStatusIndicator: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        let width: CGFloat = 60
        let height: CGFloat = 40
        let myImageView = UIImageView(frame: CGRect(x: super.bounds.width/2 - width/2 + 8, y: super.bounds.height/2 - height/2 + 22, width: width, height: height))
        var imageArray = [UIImage]()
        let size: CGFloat = 8
        for item in 0..<3 {
            let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))
            imageArray += [renderer.image { context in
                let imageContext = context.cgContext
                let circleOne = UIBezierPath(ovalIn: CGRect(x: 5, y: 10, width: size, height: size))
                let circleTwo = UIBezierPath(ovalIn: CGRect(x: 20, y: 10, width: size, height: size))
                let circleThree = UIBezierPath(ovalIn: CGRect(x: 35, y: 10, width: size, height: size))
                imageContext.setStrokeColor(UIColor.systemBackground.cgColor)
                circleOne.stroke()
                circleTwo.stroke()
                circleThree.stroke()
                imageContext.setFillColor(UIColor.lightGray.cgColor)
                let spacing = CGFloat(item)
                imageContext.addEllipse(in: CGRect(x: 5 + spacing*15, y: 10, width: size, height: size))
                imageContext.fillPath()
            }]
            
            let image = UIImage.animatedImage(with: imageArray, duration: 1)
            myImageView.image = image
            myImageView.contentMode = .center
            super.addSubview(myImageView)
        }
        
        
    }
    
}
