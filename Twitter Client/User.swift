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
        jsonDictionary = dictionary
    }
    
    func retweet(_ tweet:Tweet, completion: @escaping (Tweet) -> Void, failure: @escaping (Error) -> Void){
        TwitterClient.sharedInstance.retweet(tweet, completion: completion, failure: failure)
    }
    
    func logout(){
        TwitterClient.sharedInstance.logout()
    }

    
}
