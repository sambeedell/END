//
//  FeaturedMenuController.swift
//  END-Test
//
//  Created by Sam Beedell on 21/03/2018.
//  Copyright © 2018 Sam Beedell. All rights reserved.
//

import UIKit

class FeaturedMenuController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let titleCellID = "titleCellID"
    private let categoryCellID = "categoryCell"
    private let categoryCellWideID = "wideCategoryCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: titleCellID)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellID)
        collectionView?.register(WideCategoryCell.self, forCellWithReuseIdentifier: categoryCellWideID)
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            // get a reference to our cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: titleCellID, for: indexPath as IndexPath) as! TitleCell
            return cell
        } else if indexPath.item == 1 {
            // get a reference to our cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath as IndexPath) as! CategoryCell
            return cell
        } else {
            // get a reference to our cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: categoryCellWideID, for: indexPath as IndexPath) as! WideCategoryCell
            return cell
        }
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
//        cell.myLabel.text = self.items[indexPath.item]
//        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
    }
    
    // MARK: - UICollectionViewFlowLayout protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width:view.frame.width, height:view.frame.width)
        } else if indexPath.item == 1 {
            return CGSize(width:view.frame.width, height:400)
        } else {
            return CGSize(width:view.frame.width, height:150)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        // TODO: Caching...
    }
}

class TitleCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "deleteme")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    func setupView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        // Expand image view to frame
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
    }
}

class WideCategoryCell: CategoryCell {
    
    private let itemCellLargeID = "largeItemCellID"
    
    override func setupView() {
        super.setupView()
        itemsCollectionView.register(LargeItemCell.self, forCellWithReuseIdentifier: itemCellLargeID)
    }
    
    // make a cell for each cell index path
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellLargeID, for: indexPath as IndexPath) as! LargeItemCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //        cell.myLabel.text = self.items[indexPath.item]
        //        cell.backgroundColor = UIColor.cyan // make cell more visible in our example project
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: (frame.height / 2) - 32)
    }
    
    private class LargeItemCell: ItemCell {
        override func setupView() {
            imageView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(imageView)
            // Expand image view to frame
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        }
    }
}
