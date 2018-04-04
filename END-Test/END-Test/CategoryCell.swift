//
//  CategoryCell.swift
//  END-Test
//
//  Created by Sam Beedell on 21/03/2018.
//  Copyright © 2018 Sam Beedell. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var itemCategory: ItemCategory? {
        didSet {
            if let name = itemCategory?.name {
                categoryLabel.text = name
            }
        }
    }
    
    private let itemCellIdentifier = "itemCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let itemsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupView() {
        
        // Hard-code background colour
        self.backgroundColor = .clear
        
        // Add subviews
        addSubview(categoryLabel)
        
        // Add collection view inside cell
        addSubview(itemsCollectionView)
        
        // Connect itemsCollectionView to class
        itemsCollectionView.delegate = self
        itemsCollectionView.dataSource = self
        
        // Register collectionView Cell
        itemsCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: itemCellIdentifier)
        
        // Formats for constraints
        //let unpadded = "[v0]"
        //let padded = "-8-[v0]-8-"
        
        // Expand horizontally from left to right edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": itemsCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": categoryLabel]))
        
        // Exapnd vertically from top to bottom edge
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0(30)][v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": categoryLabel, "v1": itemsCollectionView]))
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = itemCategory?.items?.count {
            return count
        }
        return 0
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellIdentifier, for: indexPath as IndexPath) as! ItemCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        if let item = itemCategory?.items?[indexPath.item] {
            cell.item = item
        } else {
            print("error setting item")
        }
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 14, 0, 14)
    }
    
    // MARK: - UICollectionViewFlowLayout protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: (frame.height / 2) - 32)
    }
    
}
