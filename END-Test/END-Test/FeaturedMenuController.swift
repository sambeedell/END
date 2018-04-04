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
    private let categoryCellID = "categoryCellID"
    private let brandCellID = "brandCellID"
    
    var itemCategories: [ItemCategory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ItemCategory.fetchItems { [weak self] (itemCategories) in
            self?.itemCategories = itemCategories
            self?.collectionView?.reloadData()
        }
        
        setupNavigationBarItems()
        
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: titleCellID)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellID)
        collectionView?.register(BrandCell.self, forCellWithReuseIdentifier: brandCellID)
        
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = itemCategories?.count {
            return count
        }
        return 0
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
            if let itemCategory = itemCategories?[indexPath.item] {
                cell.itemCategory = itemCategory
            }
            return cell
        } else {
            // get a reference to our cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: brandCellID, for: indexPath as IndexPath) as! BrandCell
            if let itemCategory = itemCategories?[indexPath.item] {
                cell.itemCategory = itemCategory
            }
            return cell
        }
    }
    
    // MARK: - UICollectionViewFlowLayout protocol
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 0 {
            return CGSize(width:view.frame.width, height:view.frame.width)
        } else if indexPath.item == 1 {
            return CGSize(width:view.frame.width, height:470)
        } else {
            return CGSize(width:view.frame.width, height:(220 * 5))
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        // TODO: Caching...
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            let orient = UIApplication.shared.statusBarOrientation
            switch orient {
            case .portrait:
                print("Portrait")
            case .landscapeLeft,.landscapeRight :
                print("Landscape")
            default:
                print("Anything But Portrait")
            }
        }, completion: { (UIViewControllerTransitionCoordinatorContext) -> Void in
            //refresh view once rotation is completed not in will transition as it returns incorrect frame size.Refresh here
        })
        super.viewWillTransition(to: size, with: coordinator)
    }
}

extension FeaturedMenuController {
    
    func setupNavigationBarItems() {
        setupRightNavItems()
        setupLeftNavItems()
        setupRemainingNavItems()
    }
    
    private func setupRightNavItems() {
        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        let basketButton = UIButton(type: .system)
        basketButton.setImage(#imageLiteral(resourceName: "bag").withRenderingMode(.alwaysOriginal), for: .normal)
        basketButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: basketButton), UIBarButtonItem(customView: searchButton)]
    }
    
    private func setupLeftNavItems() {
        let menuButton = UIButton(type: .system)
        menuButton.setImage(#imageLiteral(resourceName: "menu").withRenderingMode(.alwaysOriginal), for: .normal)
        menuButton.frame = CGRect(x: 0, y: 0, width: 34, height: 17)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    private func setupRemainingNavItems() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 60)
        titleImageView.contentMode = .scaleAspectFit
        navigationItem.titleView = titleImageView
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
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
        iv.image = UIImage(named: "title")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    func setupView() {
        //imageView.image?.size = CGRectMake(0, 0, self.frame.width, )
        addSubview(imageView)
        // Expand image view to frame
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": imageView]))
    }
}


