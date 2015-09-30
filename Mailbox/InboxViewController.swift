//
//  InboxViewController.swift
//  Mailbox
//
//  Created by Matthew Sniff on 9/30/15.
//  Copyright © 2015 Matthew Sniff. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = imageView.image!.size
    }
    
    
}
