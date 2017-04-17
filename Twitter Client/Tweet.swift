//
//  Tweet.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import Foundation


class Tweet: NSObject{
    private static var dateFormatter: DateFormatter?
    
    var createdAtDate: Date!
    var fullDescription: String!
    var numberOfRetweets: Int
    var numberOfFavorites: Int
    var favorited: Bool
    var id: Int
    var retweetedBy: User?
    
    var author: User!

    init(dictionary: NSDictionary){
        var dictionary = dictionary
        let retweeted = dictionary["retweeted"] as! Bool
        if let retweetDictionary = dictionary["retweeted_status"] as? NSDictionary {
            retweetedBy = User(dictionary: dictionary["user"] as! NSDictionary)
            dictionary = retweetDictionary
        }
        createdAtDate = Tweet.parseDateCreated(dictionary["created_at"])
        fullDescription = dictionary["text"] as! String
        author = User(dictionary: dictionary["user"] as! NSDictionary)
        numberOfRetweets = dictionary["retweet_count"] as! Int
        numberOfFavorites = dictionary["favorite_count"] as! Int
        favorited = dictionary["favorited"] as! Bool
        id = dictionary["id"] as! Int
    }
    
    private class func parseDateCreated(_ dateCreated: Any?) -> Date {
        if Tweet.dateFormatter == nil{
            Tweet.dateFormatter = DateFormatter()
            Tweet.dateFormatter!.dateFormat = "EEE MMM dd HH:mm:ss Z yyyy" // Sat May 09 17:58:22 +0000 2009
        }
        return Tweet.dateFormatter!.date(from: dateCreated as! String)!
    }
}






