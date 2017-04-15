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
    
    var accessToken: BDBOAuth1Credential?
    
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
            self.accessToken = accessToken
            self.get("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task, response) in
                let responseDictionary = response as? NSDictionary
                let user = User(dictionary: responseDictionary)
                completion(user)
            }, failure: { (task, error) in
                print(error.localizedDescription)
            })
        }) { (error) in
            print(error!.localizedDescription)
        }
    }
    
    func getHomeTimelineTweets(completion: ([Tweet])-> Void){
        self.get(<#T##URLString: String##String#>, parameters: <#T##Any?#>, progress: <#T##((Progress) -> Void)?##((Progress) -> Void)?##(Progress) -> Void#>, success: <#T##((URLSessionDataTask, Any?) -> Void)?##((URLSessionDataTask, Any?) -> Void)?##(URLSessionDataTask, Any?) -> Void#>, failure: <#T##((URLSessionDataTask?, Error) -> Void)?##((URLSessionDataTask?, Error) -> Void)?##(URLSessionDataTask?, Error) -> Void#>)
    }
    
}
