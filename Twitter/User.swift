//
//  User.swift
//  Twitter
//
//  Created by David Bai on 9/28/14.
//  Copyright (c) 2014 David Bai. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var name: String?
    var screenname: String?
    var profileImageUrl: String?
    var profileBannerUrl: String?
    var tagline: String?
    var location: String?
    var dictionary: NSDictionary
    
    var followersCount : Int?
    var statusesCount : Int?
    var friendsCount : Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as String?
        screenname = dictionary["screen_name"] as String?
        profileImageUrl = dictionary["profile_image_url"] as String?
        profileBannerUrl = dictionary["profile_banner_url"] as String?
        tagline = dictionary["description"]  as String?
        location = dictionary["location"] as String?
        
        followersCount = dictionary["followers_count"] as Int?
        statusesCount = dictionary["statuses_count"] as Int?
        friendsCount = dictionary["friends_count"] as Int?
    }
    
    func logout() {
        User.currentUser = nil
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                if data != nil {
                    var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
        
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
