//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by David Bai on 9/28/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
    
    var tweet: Tweet?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Tweet"
        
        self.view.backgroundColor = UIColor.whiteColor()
        var tweetDetailView = TweetDetailView.instanceFromNib() as TweetDetailView
        tweetDetailView.frame.size.width = UIScreen.mainScreen().bounds.size.width
        tweetDetailView.setTweet(tweet!)
        self.view.addSubview(tweetDetailView)
    }


}
