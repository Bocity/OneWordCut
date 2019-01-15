//
//  ImageViewCell.swift
//  OneWordCut
//
//  Created by 郝进 on 2019/1/9.
//  Copyright © 2019年 Bocity. All rights reserved.
//

import UIKit

class ImageViewCell: UIView {
    let imageView = UIImageView()
    let titleLabel = UILabel()
    var initTransform:CGAffineTransform = CGAffineTransform()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 8;
        self.layer.masksToBounds = true;
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textColor = UIColor.black;
        
        imageView.contentMode = .scaleAspectFill
        
        self.addSubview(imageView);
        self.addSubview(titleLabel)
        
        self.layer.shadowColor = UIColor.lightGray.cgColor;
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 5, height: 5);
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5;
        self.backgroundColor = UIColor.white;
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height)
        titleLabel.frame = CGRect(x: self.bounds.size.width/2-75, y: 20, width: 250, height: 300)
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
}
