//
//  User.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import Foundation

class User: NSObject{
    private static let currentUserKey = "k_currentUser"
    
    var profileImageUrl: URL!
    var name: String!
    var handle: String!
    var numberOfTweets: Int!
    var numberOfFriends: Int!
    var numberOfFollowers: Int!
    
    var jsonDictionary: NSDictionary!
    
    static var _current: User?
    
    class var current: User? {
        get {
            if (_current == nil){
                if let currentUserData = UserDefaults.standard.data(forKey: currentUserKey){
                    let currentUserDictionary = try! JSONSerialization.jsonObject(with: currentUserData, options: []) as! NSDictionary
                    _current = User(dictionary: currentUserDictionary)
                }
            }
            return _current
        }
        
        set(newUser){
            _current = newUser
            if let currentUser = _current {
                let currentUserData = try! JSONSerialization.data(withJSONObject: currentUser.jsonDictionary, options: [])
                UserDefaults.standard.set(currentUserData, forKey: currentUserKey)
                UserDefaults.standard.synchronize()
            } else {
                UserDefaults.standard.removeObject(forKey: currentUserKey)
            }
        }
    }
    
    init(dictionary: NSDictionary!){
        profileImageUrl = URL(string: dictionary["profile_image_url_https"] as! String)
        name = dictionary["name"] as? String
        handle = "@\((dictionary["screen_name"] as! String))"
        numberOfTweets = dictionary["statuses_count"] as? Int
        numberOfFriends = dictionary["friends_count"] as? Int
        numberOfFollowers = dictionary["followers_count"] as? Int
        jsonDictionary = dictionary
    }
    
    func retweet(_ tweet:Tweet, completion: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void){
        TwitterClient.sharedInstance.retweet(tweet, completion: completion, failure: failure)
    }
    
    func logout(){
        TwitterClient.sharedInstance.logout()
    }

    func tweet(_ text:String, completion: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void){
        TwitterClient.sharedInstance.tweet(text, completion: completion, failure: failure)
    }
    
    func replyTo(_ tweet:Tweet, text: String, completion: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void){
        TwitterClient.sharedInstance.replyTo(tweet, text: text, completion: completion, failure: failure)
    }

    func favorite(_ tweet:Tweet, completion: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void){
        TwitterClient.sharedInstance.favorite(tweet, completion: completion, failure: failure)
    }

    
}
