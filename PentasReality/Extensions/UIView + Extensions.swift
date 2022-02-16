//
//  UIView + Extensions.swift
//  PentasReality
//
//  Created by Ikmal Azman on 14/02/2022.
// https://stackoverflow.com/questions/4754392/uiview-with-rounded-corners-and-drop-shadow

import UIKit

extension UIView {
    func dropShadow(offset : CGSize = .zero,opacity : Float = 0.2,radius: CGFloat = 1,scale : Bool = true, color : CGColor = UIColor.black.cgColor) {
        layer.masksToBounds = false
        layer.shadowColor = color
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}
