//
//  CustomExtensions.swift
//  VkClient
//
//  Created by Yuriy Fedorov on 20.12.2020.
//

import UIKit

extension UIBezierPath {
  convenience init(heartSize rect: CGFloat) {
    self.init()
    
    //Calculate Radius of Arcs using Pythagoras
    let sideOne = rect * 0.4
    let sideTwo = rect * 0.3
    let arcRadius = sqrt(sideOne*sideOne + sideTwo*sideTwo)/2
    
    //Left Hand Curve
    self.addArc(withCenter: CGPoint(x: rect * 0.3, y: rect * 0.35), radius: arcRadius, startAngle: 135.degreesToRadians, endAngle: 315.degreesToRadians, clockwise: true)
        
    //Right Hand Curve
    self.addArc(withCenter: CGPoint(x: rect * 0.7, y: rect * 0.35), radius: arcRadius, startAngle: 225.degreesToRadians, endAngle: 45.degreesToRadians, clockwise: true)
    
    //Right Bottom Line
    self.addLine(to: CGPoint(x: rect * 0.5, y: rect * 0.95))
    
    //Left Bottom Line
    self.close()
  }
}

extension Int {
    var degreesToRadians: CGFloat { return CGFloat(self) * .pi / 180 }
}

extension String {
  subscript (i: Int) -> Character {
    return self[index(startIndex, offsetBy: i)]
  }
}

extension String {
  subscript(value: CountableClosedRange<Int>) -> Substring {
    get {
      return self[index(at: value.lowerBound)...index(at: value.upperBound)]
    }
  }
  
  subscript(value: CountableRange<Int>) -> Substring {
    get {
      return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
    }
  }
  
  subscript(value: PartialRangeUpTo<Int>) -> Substring {
    get {
      return self[..<index(at: value.upperBound)]
    }
  }
  
  subscript(value: PartialRangeThrough<Int>) -> Substring {
    get {
      return self[...index(at: value.upperBound)]
    }
  }
  
  subscript(value: PartialRangeFrom<Int>) -> Substring {
    get {
      return self[index(at: value.lowerBound)...]
    }
  }
  
  func index(at offset: Int) -> String.Index {
    return index(startIndex, offsetBy: offset)
  }
}


