//
//  LoginViewController.swift
//  Twitter
//
//  Created by David Bai on 9/27/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(sender: AnyObject) {
        TwitterClient.sharedInstance.loginWithCompletion() {
            (user: User?, error: NSError?) in
            if user != nil {
                
                var navController = UINavigationController()
                var homeTimelineVC = HomeTimelineTableViewController(nibName: "HomeTimelineTableViewController", bundle: nil)
                navController.pushViewController(homeTimelineVC, animated: true)
                self.presentViewController(navController, animated: true, completion: nil)
            } else {
                // handle login error
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
