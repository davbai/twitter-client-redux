//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by David Bai on 9/27/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

let MINUTE = 60.0
let HOUR = MINUTE * 60
let DAY = HOUR * 24
let WEEK = DAY * 7
let MONTH = DAY * 31
let YEAR = DAY * 365

class TweetTableViewCell: UITableViewCell {

    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var retweetedLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var timestamp: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setTweet(tweet: Tweet) {
        profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!))
        
        nameLabel.text = tweet.user!.name!
        nameLabel.sizeToFit()
        
        screennameLabel.text = "@\(tweet.user!.screenname!)"
        screennameLabel.sizeToFit()
        
        tweetText.numberOfLines = 0
        tweetText.text = tweet.text!
        tweetText.sizeToFit()
        
        timestamp.text = getTimeElapsed(tweet.createdAt!)
        timestamp.sizeToFit()
        
        retweetCountLabel.text = String(tweet.retweetCount! as Int)
        retweetCountLabel.sizeToFit()
        
        favoriteCountLabel.text = String(tweet.favoriteCount! as Int)
        favoriteCountLabel.sizeToFit()
    }
    
    func getTimeElapsed(createdAt: NSDate) -> String {
        var timeElapsed = abs(createdAt.timeIntervalSinceNow as Double)
        
        var prefix = 0.0;
        var suffix = "";
        
        if (timeElapsed < MINUTE) {
            prefix = timeElapsed;
            suffix = "s";
        } else if (timeElapsed < HOUR) {
            prefix = timeElapsed / MINUTE;
            suffix = "m";
        } else if (timeElapsed < DAY) {
            prefix = timeElapsed / HOUR;
            suffix = "h";
        } else if (timeElapsed < WEEK) {
            prefix = timeElapsed / DAY;
            suffix = "d";
        } else if (timeElapsed < MONTH) {
            prefix = timeElapsed / WEEK;
            suffix = "w";
        } else if (timeElapsed < YEAR) {
            prefix = timeElapsed / MONTH;
            suffix = "mo";
        } else {
            prefix = timeElapsed / YEAR;
            suffix = "y";
        }
        
        return "\(Int(prefix))\(suffix)"
    }
    
}
