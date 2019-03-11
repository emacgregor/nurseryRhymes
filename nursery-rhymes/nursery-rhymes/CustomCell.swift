//
//  CustomCell.swift
//  nursery-rhymes
//
//  Created by Zachary Cheshire on 1/20/19.
//  Copyright © 2019 Team8343. All rights reserved.
//

import Foundation
import UIKit

class CustomCell: UITableViewCell {
    var message: String?
    var mainImage: UIImage?
    var homeExp = UILabel()
    var homeExpExists = false
    
    
    var messageView : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        label.textColor = UIColor.white
        return label
    }()
    
    var mainImageView : UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:1.0)
        return imageView
    }()
    
    var homeExpLabel : UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:0.0)
        label.font = UIFont(name: "FontAwesome", size: UIFont.buttonFontSize)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor(red:0.38, green:0.74, blue:0.98, alpha:0.0)
        
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        self.addSubview(homeExpLabel)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant :50).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        messageView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        messageView.rightAnchor.constraint(equalTo: self.homeExpLabel.leftAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        
        homeExpLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        homeExpLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        homeExpLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        homeExpLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if message != nil {
            messageView.text = message
        }
        if mainImage != nil {
            mainImageView.image = mainImage
        }
        
        if homeExpExists {
            homeExpLabel.text = ""
            homeExpLabel.widthAnchor.constraint(equalToConstant :50).isActive = true
        } else {
            homeExpLabel.widthAnchor.constraint(equalToConstant :0).isActive = true
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
