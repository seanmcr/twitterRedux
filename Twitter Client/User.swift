//
//  User.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import Foundation

class User: NSObject{
    var name: String?
    
    static var current: User?
    
    init(dictionary: NSDictionary!){
        name = dictionary["name"] as? String
    }
    
    func getHomeTimelineTweets(completion: ([Tweet]) -> Void){
        TwitterClient.
    }
}
