//
//  UIView+Extension.swift
//  PhotosApp
//
//  Created by Omayma Marouf on 22/08/2024.
//

import UIKit

/**
 An extension on the `UIView` class providing convenient properties and methods for modifying the appearance and layout of views.
 */
extension UIView {
    
    /**
      The width of the view's border.
      
      This property allows you to set the width of the border around the view.
      */
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    /**
      The corner radius of the view.
      
      This property allows you to set the corner radius of the view, giving it rounded corners.
      */
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    /**
     The color of the view's border.
     
     This property allows you to set the color of the border around the view.
     */
    @IBInspectable var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
    }
    
    /**
     Rounds the corners of the view to create a circular appearance.
     
     This method sets the corner radius of the view to half of its height, creating a circular shape. The `clipsToBounds` property is also set to `true` to ensure the content remains within the circular bounds.
     */
    func roundCorner() {
        let corner = self.bounds.size.height / 2
        self.layer.cornerRadius = corner
        self.clipsToBounds = true
    }
    
    /**
      Indicates whether the view has round corners.
      
      This property allows you to check whether the view currently has round corners (a circular appearance) based on its corner radius.
      */
    @IBInspectable dynamic var  hasRoundCorner: Bool {
        get {
            return self.layer.cornerRadius == self.bounds.size.height / 2
        }
        set {
            self.roundCorner()
        }
    }
    
    /**
     Indicates whether the view is a circle.
     
     This property allows you to check whether the view is a perfect circle based on its corner radius and width.
     */
    @IBInspectable dynamic var  circleView: Bool {
        get {
            return self.layer.cornerRadius == self.layer.bounds.width / 2
        }
        set {
            self.circularView()
        }
    }
    
    /**
     Converts the view into a perfect circle.
     
     This method sets the corner radius of the view to half of its width, transforming it into a perfect circle. The `clipsToBounds` property is also set to `true` to ensure the content remains within the circular bounds.
     */
    func circularView() {
        let corner = self.layer.bounds.width / 2
        self.layer.cornerRadius = corner
        self.clipsToBounds = true
    }
    
    /**
     Rounds specific corners of the view with a given radius.
     
     - Parameters:
        - corners: The corners to be rounded.
        - radius: The radius of the rounded corners.
     */
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius,
                                                    height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.position = self.center
        mask.bounds = self.frame
        self.layer.mask = mask
    }
    
    
    
    
}
