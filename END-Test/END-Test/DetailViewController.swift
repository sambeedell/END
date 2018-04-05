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
        
        // Compress scroll view to 3/4 of frame
//        let w = view.bounds.width
//        let h = view.bounds.height
//        scrollView.frame = CGRect(x: 0 , y: 0 , width: w * 0.75, height: h * 0.75)
//        scrollView.center = CGPoint(x: w / 2, y: h / 2)
        
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
        
        
    }

    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        // TODO: Follow finger before dismissing...?
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
