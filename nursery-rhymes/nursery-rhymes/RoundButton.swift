//
//  RoundButton.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 1/20/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import UIKit

@IBDesignable
class RoundButton: UIButton {
    
    private var shadowLayer: CAShapeLayer!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.position = CGPoint(x: center.x - bounds.width / 2,
                                           y: center.y - bounds.height / 2)
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 35).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            
            shadowLayer.shadowColor = UIColor.darkGray.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 5.0, height: 5.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 5
            shadowLayer.masksToBounds = true
            shadowLayer.masksToBounds = false
            
            /**
             TODO:
             Uncomment the next line to reenable shadows
             These are disabled because they fail to reqize properly when orientation changes
            */
            //self.superview?.layer.insertSublayer(shadowLayer, at: 0)
            //self.superview?.bringSubview(toFront: self)
            
            //layer.insertSublayer(shadowLayer, at: 2)
            //layer.insertSublayer(shadowLayer, below: nil) // also works
        }
    }

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            self.layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 10, height: 10) {
        didSet{
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.5
        }
    }
}
