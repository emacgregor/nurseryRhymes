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
    var fileName: String?

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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(mainImageView)
        self.addSubview(messageView)
        
        mainImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mainImageView.widthAnchor.constraint(equalToConstant :50).isActive = true
        mainImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        messageView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor).isActive = true
        ///messageView.leftAnchor.constraint(equalTo: self.mainImageView.rightAnchor, constant: 50)
        messageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        messageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        messageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let messsage = message {
            messageView.text = message
        }
        if let image = mainImage {
            mainImageView.image = image
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
