//
//  TweetComposerViewController.swift
//  Twitter
//
//  Created by David Bai on 9/28/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class TweetComposerViewController: UIViewController, UITextViewDelegate {
    
    var user : User?

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var tweetText: UITextView!
    
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var characterCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetText.delegate = self
        
        nameLabel.text = user?.name?
        screennameLabel.text = "@\(user!.screenname!)"
        
        profileImage.setImageWithURL(NSURL(string: user!.profileImageUrl! as String))
        
        tweetButton.enabled = false;
    }

    @IBAction func tweet(sender: AnyObject) {
        //status
        var params : Dictionary<String, String> = [:]
        params["status"] = tweetText.text
        
        TwitterClient.sharedInstance.postTweetWithParams(params, completion: { (tweet, error) -> () in
            self.dismissViewControllerAnimated(true, completion: nil)
        })
    }

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textViewDidChange(textView: UITextView) {
        var count = countElements(tweetText.text)
        
        if count > 0 && count <= 140 {
            tweetButton.enabled = true
        }
        
        characterCount.text = String(count)
    }
}
