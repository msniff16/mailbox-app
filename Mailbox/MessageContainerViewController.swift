//
//  MessageContainerViewController.swift
//  Mailbox
//
//  Created by Matthew Sniff on 9/30/15.
//  Copyright © 2015 Matthew Sniff. All rights reserved.
//

import UIKit

class MessageContainerViewController: UIViewController {

    // record swipe type
    enum SwipeMotion {
        case LeftToRight
        case RightToLeft
        case Default
    }
 
    @IBOutlet weak var clockIcon: UIImageView!
    @IBOutlet weak var checkIcon: UIImageView!
    @IBOutlet weak var firstMessage: UIImageView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet var containerView: UIView!
    var originalPostionX: CGFloat!
    var delegate: InboxViewController?
    var swipeMotion: SwipeMotion = SwipeMotion.Default
    
    
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
        if(velocity.x < 0 && swipeMotion != .LeftToRight) {
            
            // set type of motion to lock animation
            swipeMotion = .RightToLeft
            
            // change position of message view
            firstMessage.frame.origin.x =  point.x - 320
            clockIcon.frame.origin.x = point.x + 20
            
            // hide/unhide icons
            clockIcon.hidden = false
            checkIcon.hidden = true
            
            // change color of message view
            if( (320 - point.x > 60) && (320 - point.x <= 260) ) {
                containerView.backgroundColor =  UIColor(colorLiteralRed: 250/255.0, green: 200/255.0, blue: 51/255.0, alpha: 1.0)
                clockIcon.image = UIImage(named: "later_icon")
            }
            else if( (320 - point.x >= 260) ) {
                containerView.backgroundColor =  UIColor.brownColor()
                clockIcon.image = UIImage(named: "list_icon")
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
                    
                    print("x: \(point.x)")
                    if((320 - point.x) > 60 && (320 - point.x) <= 260) {
                        self.delegate?.rescheduleView.alpha = 1
                    }
                    else if((320 - point.x) > 260 && (320 - point.x) <= 310) {
                        self.delegate?.listView.alpha = 1
                    }
                    
                    self.firstMessage.frame.origin.x = 0
                    self.containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                    self.clockIcon.frame.origin.x = 290
                    self.swipeMotion = .Default
                    
                })
            }
            
        }
        
        // swiping left to right
        else if(velocity.x > 0 && swipeMotion != .RightToLeft) {
            
            // set type of motion to lock animation
            swipeMotion = .LeftToRight
            
            // change position of message view
            firstMessage.frame.origin.x = point.x
            checkIcon.frame.origin.x = point.x - 40
            
            // hide/unhide icons
            checkIcon.hidden = false
            clockIcon.hidden = true
            
            // change color of message view
            if(point.x >= 60 && point.x < 260) {
                containerView.backgroundColor =  UIColor(colorLiteralRed: 112/255.0, green: 217/255.0, blue: 98/255.0, alpha: 1.0)
                 checkIcon.image = UIImage(named: "archive_icon")
            }
            else if(point.x >= 260) {
                containerView.backgroundColor =  UIColor(colorLiteralRed: 235/255.0, green: 84/255.0, blue: 51/255.0, alpha: 1.0)
                checkIcon.image = UIImage(named: "delete_icon")
            }
            else {
                containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
            }
            
            // gesture stopped
            if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.firstMessage.frame.origin.x = 0
                    self.containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                    self.swipeMotion = .Default
                })
            }
            
        }
        
        // swiped left to right and then swiped right to left
        if(velocity.x < 0 && swipeMotion == .LeftToRight) {
            if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.firstMessage.frame.origin.x = 0
                    self.containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                    self.swipeMotion = .Default
                })
            }
        }
        
        // swiped right to left and then swiped left to right
        if(velocity.x > 0 && swipeMotion == .RightToLeft) {
            if panGestureRecognizer.state == UIGestureRecognizerState.Ended {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.firstMessage.frame.origin.x = 0
                    self.containerView.backgroundColor = UIColor.groupTableViewBackgroundColor()
                    self.swipeMotion = .Default
                })
            }
        }
        
    }
    
    
    
    
    
}
