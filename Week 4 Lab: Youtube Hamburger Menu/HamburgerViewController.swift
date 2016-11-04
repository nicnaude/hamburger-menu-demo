//
//  HamburgerViewController.swift
//  Week 4 Lab: Youtube Hamburger Menu
//
//  Created by Nicholas Naudé on 03/11/2016.
//  Copyright © 2016 Nicholas Naudé. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var menuViewControllerView: UIView!
    @IBOutlet weak var feedViewControllerView: UIView!
    
    //Class variables
    var menuViewController: UIViewController!
    var feedViewController: UIViewController!
    var feedViewControllerViewSlide: CGPoint!
    var feedViewControllerViewOriginalCenter: CGPoint!
    var feedViewSlideOffset: CGFloat!
    var feedViewControllerViewOriginalCenterSlide: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // programmatically create new view controller copies of the menu and the feed view controllers
        let main = UIStoryboard(name: "Main", bundle: nil)
        
        menuViewController = main.instantiateViewController(withIdentifier: "menuViewController")
        menuViewControllerView.addSubview(menuViewController.view)
        
        feedViewController = main.instantiateViewController(withIdentifier: "feedViewController")
        feedViewControllerView.addSubview(feedViewController.view)
        
        feedViewControllerViewOriginalCenter = feedViewControllerView.center
        
        feedViewSlideOffset = 275
        
        feedViewControllerViewSlide = CGPoint(x: feedViewControllerViewOriginalCenter.x + feedViewSlideOffset, y: feedViewControllerViewOriginalCenter.y)
        
    }
    
    @IBAction func onButtonTapped(_ sender: UIButton) {
        print("Tapped")
    }
    
    // Upon gesture ended, use the velocity to determine if the menu should be fully revealed or hidden.
    @IBAction func onFeedPanned(_ sender: UIPanGestureRecognizer) {
        print("Yay")
        let translation = sender.translation(in: view)
        
        
        if sender.state == .began {
            print("sender.state == .began")
            feedViewControllerViewOriginalCenterSlide = feedViewControllerView.center
            
        } else if sender.state == .changed {
            print("sender.state == .changed")
            self.feedViewControllerView.center = CGPoint(x: self.feedViewControllerViewOriginalCenterSlide.x + translation.x, y: self.feedViewControllerViewOriginalCenterSlide.y)
            
            
        } else if sender.state == .ended {
            if translation.x < 0 {
                UIView.animate(withDuration: 0.3) {
                    print("Moved: left")
                    
                    UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveEaseInOut, animations: {
                        
                        self.feedViewControllerView.center = self.feedViewControllerViewOriginalCenter
                        
                    }, completion: nil)
                }
            } else if translation.x > 0 {
                UIView.animate(withDuration: 0.3) {
                    print("Moved: right")
                    self.feedViewControllerView.center = self.feedViewControllerViewSlide
                }
            }
        }
    } // The end of the pan
    
} // And they lived happily ever after.
