//
//  MessageContainerViewController.swift
//  Mailbox
//
//  Created by Matthew Sniff on 9/30/15.
//  Copyright © 2015 Matthew Sniff. All rights reserved.
//

import UIKit

class MessageContainerViewController: UIViewController {

    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var firstMessage: UIImageView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet var containerView: UIView!
    var originalPostionX: CGFloat!
    var delegate: InboxViewController?

    
    // view loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        originalPostionX = firstMessage.frame.origin.x
    }

    // panned on first message
    @IBAction func onPanFirstMessage(sender: UIPanGestureRecognizer) {
        
        // point & velocity of pan
        let point = panGestureRecognizer.locationInView(view)
        let velocity = panGestureRecognizer.velocityInView(view)

        
        // swiping right to left
        if(velocity.x < 0) {
            
            // change position of message view
            firstMessage.frame.origin.x =  point.x - 320
            
            // change color of message view
            if(320 - point.x > 60) {
                containerView.backgroundColor =  UIColor(colorLiteralRed: 250/255.0, green: 200/255.0, blue: 51/255.0, alpha: 1.0)
            }
            else {
                containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }
            
            // show reschedule view when message slid all way to left
            if(320 - point.x >= 310) {
                
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.firstMessage.frame.origin.x = 0
                    self.delegate?.rescheduleView.alpha = 1
                })
                
            }
            
            // gesture stopped
            if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.firstMessage.frame.origin.x = 0
                    self.containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                })
            }
            
        }
        
        // swiping left to right
        else {
            
            // change position of message view
            firstMessage.frame.origin.x = point.x
            
            // change color of message view
            if(point.x >= 60 && point.x < 260) {
                containerView.backgroundColor =  UIColor(colorLiteralRed: 112/255.0, green: 217/255.0, blue: 98/255.0, alpha: 1.0)
            }
            else if(point.x >= 260) {
                containerView.backgroundColor =  UIColor(colorLiteralRed: 235/255.0, green: 84/255.0, blue: 51/255.0, alpha: 1.0)
            }
            else {
                containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }
            
            // gesture stopped
            if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.firstMessage.frame.origin.x = 0
                    self.containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                })
            }
            
        }
        
    }
    
    
    
    
    
}
