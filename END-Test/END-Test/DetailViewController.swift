//
//  DetailViewController.swift
//  END-Test
//
//  Created by Sam Beedell on 04/04/2018.
//  Copyright © 2018 Sam Beedell. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIViewControllerTransitioningDelegate {

    var item: Item?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var colourLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionClose(_:))))
        
        // Create blurred background
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.sendSubview(toBack: blurEffectView)
        
        // Round edges of scrollView
        scrollView.layer.cornerRadius = 40
        scrollView.layer.masksToBounds = true
        
        // Compress scroll view to orientation
        viewWillLayoutSubviews()
        
        // Load data into UI elements
        if let title = item?.title {
            titleLabel.text = title
        }
        if let colour = item?.colour {
            colourLabel.text = colour
        }
        if let price = item?.price {
            priceLabel.text = "£\(price)"
        }
        if let imageName = item?.image {
            imageView.image = UIImage(named: imageName)
        }
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis lectus cursus, luctus metus ut, auctor turpis. Donec ultrices dolor non turpis aliquet consequat. Mauris faucibus quam non dignissim convallis. Etiam iaculis sapien ut metus aliquam, id tincidunt est sollicitudin. Aliquam erat volutpat. Aenean ligula nisi, dignissim ac sem quis, ultricies sollicitudin justo. Donec sit amet urna orci. Morbi ipsum neque, condimentum vitae fringilla et, sagittis vel lectus. Maecenas imperdiet nibh non lorem porttitor suscipit. Vivamus sed neque eu ligula imperdiet convallis sed in nunc. \n\nDuis bibendum est nec maximus consequat. Cras vestibulum lorem et tempor pharetra. Sed sed laoreet tortor, in vestibulum nunc. Sed suscipit magna a neque blandit, dignissim hendrerit mauris vestibulum. In orci enim, placerat a felis in, vulputate laoreet turpis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum pulvinar sapien nisi, blandit rutrum nulla bibendum id. Phasellus a nisi facilisis, vehicula ex at, fermentum augue. Maecenas sapien velit, fermentum ac lorem at, tincidunt feugiat mauris. Aenean euismod consequat lorem ut commodo. Ut sodales nisl sit amet pellentesque egestas. Curabitur vel nisi sit amet massa laoreet commodo. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis lectus cursus, luctus metus ut, auctor turpis. Donec ultrices dolor non turpis aliquet consequat. Mauris faucibus quam non dignissim convallis. Etiam iaculis sapien ut metus aliquam, id tincidunt est sollicitudin. Aliquam erat volutpat. Aenean ligula nisi, dignissim ac sem quis, ultricies sollicitudin justo. Donec sit amet urna orci. Morbi ipsum neque, condimentum vitae fringilla et, sagittis vel lectus. Maecenas imperdiet nibh non lorem porttitor suscipit. Vivamus sed neque eu ligula imperdiet convallis sed in nunc. \n\nDuis bibendum est nec maximus consequat. Cras vestibulum lorem et tempor pharetra. Sed sed laoreet tortor, in vestibulum nunc. Sed suscipit magna a neque blandit, dignissim hendrerit mauris vestibulum. In orci enim, placerat a felis in, vulputate laoreet turpis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum pulvinar sapien nisi, blandit rutrum nulla bibendum id. Phasellus a nisi facilisis, vehicula ex at, fermentum augue. Maecenas sapien velit, fermentum ac lorem at, tincidunt feugiat mauris. Aenean euismod consequat lorem ut commodo. Ut sodales nisl sit amet pellentesque egestas. Curabitur vel nisi sit amet massa laoreet commodo. END \n\n"
        
        // Ensure the scrollView is the right size of its content
        //scrollView.sizeToFit()
        descriptionLabel.sizeToFit()
        NSLayoutConstraint.activate([
            scrollView.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor)
            ])
    }

    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        // Prepare view before dismissing
        prepareDetailViewForDismissal()
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func prepareDetailViewForDismissal() {
        UIView.animate(withDuration: 0.9, animations: {
            
            // Scroll to the top
            self.scrollView.scrollToTop(animated: true)
            self.scrollView.layer.masksToBounds = false // allows imageview to visibly grow outside frame
            
            // Make view a square
            if self.view.frame.width > self.view.frame.height {
                // Landscape
                self.view.frame = CGRect(x: self.scrollView.frame.origin.x, y: self.scrollView.frame.origin.y, width: self.view.frame.height, height: self.view.frame.height)
            } else {
                // Portrait
                self.view.frame = CGRect(x: self.scrollView.frame.origin.x, y: self.scrollView.frame.origin.y, width: self.view.frame.width, height: self.view.frame.width)
            }
            
            // Hide all UI elements
            self.colourLabel.isHidden = true
            self.titleLabel.isHidden = true
            self.priceLabel.isHidden = true
            self.descriptionLabel.isHidden = true
            
            // Enlarge imageView
            NSLayoutConstraint.activate([
                self.imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
                self.imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
                self.imageView.topAnchor.constraint(equalTo: self.view.topAnchor),
                self.imageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
                ])
            
        }, completion: nil)
    }
}

extension UIScrollView {
    // Scroll to top
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
}

extension DetailViewController {
    override func viewWillLayoutSubviews() {
        let orientation = UIDevice.current.orientation
        if orientation.isLandscape {
            configureScrollViewConstraintsFor(constant: UIScreen.main.bounds.width / 4)
        } else if orientation.isPortrait {
            configureScrollViewConstraintsFor(constant: UIScreen.main.bounds.width / 8)
        }
    }
    
    fileprivate func configureScrollViewConstraintsFor(constant const: CGFloat) {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: const),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -(const))
            ])
    }
}
