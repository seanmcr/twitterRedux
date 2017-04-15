//
//  TwitterClient.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import Foundation
import BDBOAuth1Manager


class TwitterClient : BDBOAuth1SessionManager {
    private static let baseUrl: URL! = URL(string: "https://api.twitter.com")
    private static let consumerKey: String = "X0lyGc1qHep8iI3alF1tGKp6z"
    private static let consumerSecret = "G7mfgq7DTxluiTR8gZ8r0ouuGjO5nVpX4LejqtaNDKrA9gVBMo"
    private static let baseAuthorizeUrlString = "https://api.twitter.com/oauth/authorize"
    private static let callBackUrl: URL! = URL(string: "twitterclient://oauth")
    private static let acceesTokenKey: String! = "k_accessToken"
    
    static let userDidLogOutNotification = Notification.Name("userDidLogOut")
    
    static let sharedInstance: TwitterClient = {
        let instance = TwitterClient(baseURL: baseUrl, consumerKey: consumerKey, consumerSecret: consumerSecret)!
        return instance
    }()
    
    func fetchRequestToken() {
        self.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: TwitterClient.callBackUrl, scope: nil, success: { (credential) in
            let authUrlString = "\(TwitterClient.baseAuthorizeUrlString)?oauth_token=\(credential!.token!)"
            let authorizeUrl = URL(string: authUrlString)!
            UIApplication.shared.open(authorizeUrl, options: [:], completionHandler: nil)
        }) { (error) in
            print(error!.localizedDescription)
        }
    }
    
    func login(withCredential credential: BDBOAuth1Credential!, completion: @escaping (_ user: User) -> Void) {
        self.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: credential, success: { (accessToken) in
            self.requestSerializer.saveAccessToken(accessToken)

            self.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
                let responseDictionary = response as? NSDictionary
                let user = User(dictionary: responseDictionary)
                User.current = user
                completion(user)
            }, failure: { (task, error) in
                print(error.localizedDescription)
            })
        }) { (error) in
            print(error!.localizedDescription)
        }
    }

    func logout(){
        self.deauthorize()
        User.current = nil
        NotificationCenter.default.post(name: TwitterClient.userDidLogOutNotification, object: nil)
    }
    
    func getHomeTimelineTweets(completion: @escaping (_ tweets: [Tweet])-> Void, failure: @escaping (_ error: Error) -> Void){
        
        self.get("1.1/statuses/home_timeline.json", parameters: ["count" : 20], progress: nil, success: { (task, response) in
            if let responseDictionaries = response as? [NSDictionary]{
                var tweets: [Tweet] = []
                for dictionary in responseDictionaries{
                    tweets.append(Tweet(dictionary: dictionary))
                }
                completion(tweets)
            }
        }) { (task, error) in
            failure(error)
        }
    }
    
}
