//
//  BrandCell.swift
//  END-Test
//
//  Created by Sam Beedell on 30/03/2018.
//  Copyright © 2018 Sam Beedell. All rights reserved.
//

import UIKit

class BrandCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let brandCellIdentifier = "brandCell"
    private let collectionViewCount = 5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let brandLabel: UILabel = {
        let label = UILabel()
        label.text = "BRANDS"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let brandsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        //layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isUserInteractionEnabled = false
        return collectionView
    }()
    
    func setupView() {
        
        // Hard-code background colour
        self.backgroundColor = .clear
        
        // Add subviews
        addSubview(brandLabel)
        
        // Add collection view inside cell
        addSubview(brandsCollectionView)
        
        // Connect itemsCollectionView to class
        brandsCollectionView.delegate = self
        brandsCollectionView.dataSource = self
        
        // Register collectionView Cell
        brandsCollectionView.register(BrandItemCell.self, forCellWithReuseIdentifier: brandCellIdentifier)
        
        // Expand horizontally from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": brandsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": brandLabel]))
        
        // Exapnd vertically from top to bottom edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)][v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": brandLabel, "v1": brandsCollectionView]))
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCount
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brandCellIdentifier, for: indexPath as IndexPath) as! BrandItemCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //        cell.myLabel.text = self.items[indexPath.item]
        //        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected brand cell #\(indexPath.item)!")
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsetsMake(0, 14, 0, 14)
//    }
    
    // MARK: - UICollectionViewFlowLayout protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.size.width, height: (220) - 32)
    }
    
    private class BrandItemCell: ItemCell {
        override func setupView() {
            imageView.image = UIImage(named: "brandme")
            addSubview(imageView)
            
            imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 220 - 35)
        }
    }
    
}
