//
//  AvatarViewController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 19.12.2020.
//

import UIKit

@IBDesignable class AvatarRounderViewController: UIImageView {
    
    var cornerRadius: CGFloat {
        return frame.width/2
    }
    
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
        setCornerRadius(value: cornerRadius)
    }
    
    func setCornerRadius(value: CGFloat) {
        layer.cornerRadius = value
    }
}
