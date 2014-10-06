//
//  ContainerViewController.swift
//  Twitter
//
//  Created by David Bai on 10/5/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController {

    @IBOutlet weak var contentViewXConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var mentionsButton: UIButton!
    @IBOutlet weak var profileButton: UIButton!
    

    @IBOutlet weak var contentView: UIView!
    
    var viewControllers: [UIViewController] = []
    
    var activeViewController: UIViewController? {
        didSet(oldViewControllerOrNil) {
            if let oldVC = oldViewControllerOrNil {
                oldVC.willMoveToParentViewController(nil)
                oldVC.view.removeFromSuperview()
                oldVC.removeFromParentViewController()
            }
            
            if let newVC = activeViewController {
                self.addChildViewController(newVC)
                newVC.view.autoresizingMask = .FlexibleWidth | .FlexibleHeight
                newVC.view.frame = self.contentView.bounds
                self.contentView.addSubview(newVC.view)
                newVC.didMoveToParentViewController(self)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.contentViewXConstraint.constant = 0
        
        var homeNavController = UINavigationController()
        var homeTimelineVC = HomeTimelineTableViewController(nibName: "HomeTimelineTableViewController", bundle: nil)
        homeNavController.pushViewController(homeTimelineVC, animated: true)
        viewControllers.append(homeNavController)
        
        var mentionNavController = UINavigationController()
        var mentionTimelineVC = HomeTimelineTableViewController(nibName: "HomeTimelineTableViewController", bundle: nil)
        mentionTimelineVC.timelineType = "mention"
        mentionNavController.pushViewController(mentionTimelineVC, animated: true)
        viewControllers.append(mentionNavController)
        
        var profileVC = UserProfileViewController(nibName: "UserProfileViewController", bundle: nil)
        profileVC.user = User.currentUser
        viewControllers.append(profileVC)
        
        self.activeViewController = homeNavController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .Ended {
            UIView.animateWithDuration(0.35, animations: {
                self.contentViewXConstraint.constant = -160
                self.view.layoutIfNeeded()
            });
        }
    }

    @IBAction func didTapSidebarButton(sender: UIButton) {
        if sender == homeButton {
            self.activeViewController = viewControllers[0]
        } else if sender == mentionsButton {
            self.activeViewController = viewControllers[1]
        } else if sender == profileButton {
            self.activeViewController = viewControllers[2]
        } else {
            NSLog("unknown button")
        }
        
        UIView.animateWithDuration(0.35, animations: {
            self.contentViewXConstraint.constant = 0
            self.view.layoutIfNeeded()
        });
    }
    
    


}
