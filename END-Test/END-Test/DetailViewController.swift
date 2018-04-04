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
        descriptionLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus quis lectus cursus, luctus metus ut, auctor turpis. Donec ultrices dolor non turpis aliquet consequat. Mauris faucibus quam non dignissim convallis. Etiam iaculis sapien ut metus aliquam, id tincidunt est sollicitudin. Aliquam erat volutpat. Aenean ligula nisi, dignissim ac sem quis, ultricies sollicitudin justo. Donec sit amet urna orci. Morbi ipsum neque, condimentum vitae fringilla et, sagittis vel lectus. Maecenas imperdiet nibh non lorem porttitor suscipit. Vivamus sed neque eu ligula imperdiet convallis sed in nunc. \nDuis bibendum est nec maximus consequat. Cras vestibulum lorem et tempor pharetra. Sed sed laoreet tortor, in vestibulum nunc. Sed suscipit magna a neque blandit, dignissim hendrerit mauris vestibulum. In orci enim, placerat a felis in, vulputate laoreet turpis. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum pulvinar sapien nisi, blandit rutrum nulla bibendum id. Phasellus a nisi facilisis, vehicula ex at, fermentum augue. Maecenas sapien velit, fermentum ac lorem at, tincidunt feugiat mauris. Aenean euismod consequat lorem ut commodo. Ut sodales nisl sit amet pellentesque egestas. Curabitur vel nisi sit amet massa laoreet commodo."
        
        
        // dynamically resize the scroll view based on the height of the description label
//        if #available(iOS 11.0, *) {
//            scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
//        } else {
//            // Fallback on earlier versions
//        }
    }

    @objc func actionClose(_ tap: UITapGestureRecognizer) {
        // TODO: Follow finger before dismissing...?
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
