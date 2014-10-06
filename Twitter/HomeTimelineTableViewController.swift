//
//  HomeTimelineTableViewController.swift
//  Twitter
//
//  Created by David Bai on 9/27/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class HomeTimelineTableViewController: UITableViewController {
    
    var tweets: [Tweet] = [Tweet]()
    var timelineType = "home"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "tweetCell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.navigationItem.title = "Home"
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.translucent = false
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 0.239, green: 0.631, blue: 0.926, alpha: 1.0)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: UIBarButtonItemStyle.Bordered, target: self, action: "logout:")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Compose", style: UIBarButtonItemStyle.Bordered, target: self, action: "displayTweetComposerView:")
        
        loadHomeTimeline()
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    func loadHomeTimeline() {
        if timelineType == "home" {
            TwitterClient.sharedInstance.getHomeTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets!
                self.tableView.reloadData()
            })
        } else {
            TwitterClient.sharedInstance.getMentionTimelineWithParams(nil, completion: { (tweets, error) -> () in
                self.tweets = tweets!
                self.tableView.reloadData()
            })
        }
    }
    
    func refresh(sender: AnyObject?) {
        loadHomeTimeline()
        self.refreshControl?.endRefreshing()
    }
    
    func logout(sender: AnyObject?) {
        User.currentUser?.logout()
    }
    
    func displayTweetComposerView(sender: AnyObject?) {
        var tweetComposerVC = TweetComposerViewController(nibName: "TweetComposerViewController", bundle: nil)
        tweetComposerVC.user = User.currentUser?
        self.navigationController?.presentViewController(tweetComposerVC, animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) as TweetTableViewCell

        cell.setTweet(tweets[indexPath.row])
        cell.profileImage.userInteractionEnabled = true
        
        var tap = UITapGestureRecognizer(target: self, action: "didTapProfileImage:");
        cell.profileImage.tag = indexPath.row
        cell.profileImage.addGestureRecognizer(tap)

        return cell
    }


    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var tweetDetailVC = TweetDetailViewController()
        tweetDetailVC.tweet = tweets[indexPath.row]
        self.navigationController?.pushViewController(tweetDetailVC, animated: true)
    }
    
    func didTapProfileImage(sender: AnyObject?) {
        let tap = sender as UITapGestureRecognizer
        let view = tap.view as UIImageView
        var userProfileVC = UserProfileViewController(nibName: "UserProfileViewController", bundle: nil)
        userProfileVC.user = tweets[view.tag].user?
        
        self.navigationController?.pushViewController(userProfileVC, animated: true)
    }
    
}
