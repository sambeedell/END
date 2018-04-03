//
//  ItemCell.swift
//  END-Test
//
//  Created by Sam Beedell on 22/03/2018.
//  Copyright © 2018 Sam Beedell. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Properties
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "deleteme")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Drawing"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let colourLabel: UILabel = {
        let label = UILabel()
        label.text = "Green & Black"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "1.99"
        label.font = UIFont.systemFont(ofSize: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    func setupView() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(colourLabel)
        addSubview(priceLabel)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.width)
        titleLabel.frame = CGRect(x: 0, y: frame.width + 2, width: frame.width, height: 20)
        colourLabel.frame = CGRect(x: 0, y: frame.width + 17, width: frame.width, height: 20)
        priceLabel.frame = CGRect(x: 0, y: frame.width + 32, width: frame.width, height: 20)
    }
}