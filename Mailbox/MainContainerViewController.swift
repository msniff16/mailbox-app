//
//  MainContainerViewController.swift
//  Mailbox
//
//  Created by Matthew Sniff on 9/30/15.
//  Copyright © 2015 Matthew Sniff. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var navMenu: UIImageView!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var edgeGesture = UIScreenEdgePanGestureRecognizer(target: self, action: "onEdgePan:")
        edgeGesture.edges = UIRectEdge.Left
        containerView.addGestureRecognizer(edgeGesture)
        
    }
    
    // panned from container's edge
    func onEdgePan(sender: UIScreenEdgePanGestureRecognizer) {
       
        // point & velocity of pan
        let point = sender.locationInView(view)
        let velocity = sender.velocityInView(view)
        
        // change position of the containing view
        containerView.frame.origin.x = point.x
        
        print("Gesture began at: \(point)")

    }

}
