//
//  ShadowViewController.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 19.12.2020.
//

import UIKit


@IBDesignable class ShadowViewController: UIImageView {
    
    @IBInspectable var shadowColor: UIColor = .black
    @IBInspectable var shadowOpacity: Float = 1
    @IBInspectable var shadowRadius: CGFloat = 8
    @IBInspectable var shadowOffset: CGSize = .zero
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        addRounder()
        addShadow()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addRounder()
        addShadow()
    }
    
    override func prepareForInterfaceBuilder() {
        addRounder()
        addShadow()
    }
        
    func addRounder() {
        layer.cornerRadius = frame.width / 2
    }
    
    func addShadow() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        layer.shadowOffset = shadowOffset
        layer.masksToBounds = false
    }
}
