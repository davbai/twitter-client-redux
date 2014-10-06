//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by David Bai on 10/5/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    var user : User!
    
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var bannerImageView: UIImageView!
    
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var friendsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screennameLabel.text = "@\(user.screenname!)"
        nameLabel.text = user.name as String?
        
        if user.profileImageUrl != nil {
            profileImageView.setImageWithURL(NSURL(string: user.profileImageUrl!))
        }
        
        if (user.profileBannerUrl != nil) {
            bannerImageView.setImageWithURL(NSURL(string: user.profileBannerUrl!))
        }
        
        var blur:UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        var effectView:UIVisualEffectView = UIVisualEffectView (effect: blur)
        effectView.frame = bannerImageView.frame
        bannerImageView.addSubview(effectView)
        
        tweetsCount.text = "\(user.statusesCount!)"
        friendsCount.text = "\(user.friendsCount!)"
        followersCount.text = "\(user.followersCount!)"

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
