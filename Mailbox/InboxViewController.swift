//
//  InboxViewController.swift
//  Mailbox
//
//  Created by Matthew Sniff on 9/30/15.
//  Copyright © 2015 Matthew Sniff. All rights reserved.
//

import UIKit

class InboxViewController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var messageContainer: UIView!
    @IBOutlet weak var rescheduleView: UIImageView!
    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.contentSize = imageView.image!.size
    }
    
    // segue for embedded container view
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        // set delegate of container view
        if let messageVC = segue.destinationViewController as? MessageContainerViewController {
            messageVC.delegate = self
        }
    
    }
    
    // tapped the reschedule view, show first message again
    @IBAction func onRescheduleTap(sender: UITapGestureRecognizer) {
        
        rescheduleView.alpha = 0
        self.messageContainer.frame = CGRectMake(0, 0, 320, 0)
        
        UIView.animateWithDuration(1.0, animations: {
            self.messageContainer.frame = CGRectMake(0, 0, 320, 86)
        })
        
    }
    
    
}
