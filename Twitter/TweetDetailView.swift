//
//  TweetDetailView.swift
//  Twitter
//
//  Created by David Bai on 9/27/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

class TweetDetailView: UIView {

    @IBOutlet weak var profileImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    
    @IBOutlet weak var topBorderView: UIView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    var tweet : Tweet?
    
    func setTweet(tweet: Tweet) {
        self.tweet = tweet
        
        profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl! as String))
        
        nameLabel.text = tweet.user!.name!
        screennameLabel.text = "@\(tweet.user!.screenname!)"
        
        if tweet.retweetCount! == 0 {
            retweetLabel.text = ""
            retweetCountLabel.text = ""
        } else {
            retweetLabel.text = tweet.retweetCount == 1 ? "RETWEET" : "RETWEETS"
            retweetCountLabel.text = String(tweet.retweetCount! as Int)
        }
        
        retweetLabel.sizeToFit()
        retweetCountLabel.sizeToFit()
        
        if tweet.favoriteCount! == 0 {
            favoriteLabel.text = ""
            favoriteCountLabel.text = ""
        } else {
            favoriteLabel.text = tweet.favoriteCount == 1 ? "FAVORITE" : "FAVORITES"
            favoriteCountLabel.text = String(tweet.favoriteCount! as Int)
        }
        
        if tweet.favoriteCount == 0 && tweet.retweetCount == 0 {
            topBorderView.hidden = true
        }
        
        favoriteLabel.sizeToFit()
        favoriteCountLabel.sizeToFit()
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "M/d/yy, HH:mm a"
        timestamp.text = dateFormatter.stringFromDate(tweet.createdAt!)
        timestamp.sizeToFit()
        
        tweetText.numberOfLines = 0
        tweetText.text = tweet.text!
        tweetText.sizeToFit()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "TweetDetailView", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as UIView
    }
    
    @IBAction func retweet(sender: AnyObject) {
        TwitterClient.sharedInstance.postRetweetWithParams(tweet!.idStr!, params: nil) { (tweet, error) -> () in
            var image = UIImage(named: "retweet_on")
            self.retweetButton.setImage(image, forState: UIControlState.Normal)
        }
    }
    
    @IBAction func favorite(sender: AnyObject) {
        var params : Dictionary<String, String> = ["id" : tweet!.idStr!]
        TwitterClient.sharedInstance.postFavoriteWithParams(params, completion: { (tweet, error) -> () in
            var image = UIImage(named: "favorite_on")
            self.favoriteButton.setImage(image, forState: UIControlState.Normal)
        })
    }

}
