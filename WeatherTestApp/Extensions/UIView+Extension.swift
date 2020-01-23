//
//  UIView+Extension.swift
//  WeatherTestApp
//
//  Created by Vitalii Sydorskyi on 1/18/20.
//  Copyright © 2020 Vitalii Sydorskyi. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
    
    let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    static func nib() -> UINib {
        
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static func reuseIdentifier() -> String {
        
        return String(describing: self)
    }
}
