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
    
    let transition = PopAnimator()
    var selectedImage: UIImageView?
//    var blurEffectView: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        ItemCategory.fetchItems { [weak self] (itemCategories) in
            self?.itemCategories = itemCategories
            self?.collectionView?.reloadData()
        }
        
        transition.dismissCompletion = {
            self.selectedImage!.isHidden = false
//            self.blurEffectView.removeFromSuperview()
        }
        
        setupNavigationBarItems()
        
        collectionView?.register(TitleCell.self, forCellWithReuseIdentifier: titleCellID)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: categoryCellID)
        collectionView?.register(BrandCell.self, forCellWithReuseIdentifier: brandCellID)
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
//        blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
            cell.delegate = self
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
            if let count = itemCategories?[indexPath.item].items?.count {
                return CGSize(width:view.frame.width, height:CGFloat(220 * count))
            }
            return CGSize(width:view.frame.width, height:220)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
        // TODO: Caching...
    }
    
    fileprivate func printOrientation() {
        let orient = UIApplication.shared.statusBarOrientation
        switch orient {
        case .portrait:
            print("Portrait")
        case .landscapeLeft,.landscapeRight :
            print("Landscape")
        default:
            print("Anything But Portrait")
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { [unowned self] _ -> Void in
            //self.printOrientation()
            DispatchQueue.main.async {
                self.collectionView?.collectionViewLayout.invalidateLayout()
                self.collectionView?.reloadData()
            }
        }, completion: { _ -> Void in
            // refresh view once rotation is completed (must be here to return correct frame) -> causes jumpy UI?
            
        })
    }
}

extension FeaturedMenuController: CategoryCellDelegate, UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.originFrame = selectedImage!.superview!.convert(selectedImage!.frame, to: nil)
        transition.presenting = true
        selectedImage!.isHidden = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
    
    // Delegate method
    func itemPressedFor(cell: CategoryItemCell) {
        
        // Blur background
//        view.addSubview(blurEffectView)
        
        selectedImage = cell.imageView
        
        //present details view controller
        let itemDetails = DetailViewController()
        itemDetails.item = cell.item
        
        itemDetails.modalPresentationStyle = .overCurrentContext
        itemDetails.transitioningDelegate = self // UIKit will now ask ViewController for an animator object
        
        present(itemDetails, animated: true, completion: nil)
        
        
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


