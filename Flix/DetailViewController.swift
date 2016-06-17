//
//  DetailViewController.swift
//  Flix
//
//  Created by Juan Luis Herrero Estrada on 6/16/16.
//  Copyright © 2016 Juan Luis Herrero Estrada. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width,height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as? String
        titleLabel.text = title
        
        let description = movie["overview"] as? String
        descriptionLabel.text = description
        
        descriptionLabel.sizeToFit()
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            posterView.setImageWithURL(posterUrl!)
        }
        else {
            posterView.image = nil
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
