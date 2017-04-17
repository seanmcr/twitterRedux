//
//  TweetViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import ARSLineProgress

class TweetViewController: UIViewController {
    private static let dateFormatter = DateFormatter()
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var numberFavoritesLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    
    @IBOutlet weak var favoritedButton: UIButton!
    
    var tweet: Tweet? {
        didSet{
            if (self.isViewLoaded){
                updateViewsWithCurrentTweet()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TweetViewController.dateFormatter.dateStyle = .medium
        TweetViewController.dateFormatter.timeStyle = .medium
        updateViewsWithCurrentTweet()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController {
            let replyTweetController = navController.topViewController as! NewTweetViewController
            replyTweetController.isInReplyTo = self.tweet
        }
    }
    
    func updateViewsWithCurrentTweet(){
        if let tweet = tweet {
            authorNameLabel.text = tweet.author.name
            authorHandleLabel.text = tweet.author.handle
            tweetTextLabel.text = tweet.fullDescription
            createdAtLabel.text = TweetViewController.dateFormatter.string(from: tweet.createdAtDate)
            authorImageView.setImageWith(tweet.author.profileImageUrl)
            numberTweetsLabel.text = "\(tweet.numberOfRetweets)"
            numberFavoritesLabel.text = "\(tweet.numberOfFavorites)"
            favoritedButton.imageView?.image = tweet.favorited ? #imageLiteral(resourceName: "twitter_favorite_on") : #imageLiteral(resourceName: "twitter_favorite")
        }
    }
    
    @IBAction func onReplyButton(_ sender: Any) {
        
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        User.current!.retweet(tweet!, completion: { (updatedTweet) in
            self.tweet = updatedTweet
            self.updateViewsWithCurrentTweet()
        }) { (error) in
            ARSLineProgress.showFail()
        }
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
        User.current!.favorite(tweet!, completion: { (updatedTweet) in
            self.tweet = updatedTweet
            self.updateViewsWithCurrentTweet()
        }) { (error) in
            ARSLineProgress.showFail()
        }
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
