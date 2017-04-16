//
//  TweetViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {
    private static let dateFormatter = DateFormatter()
    
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    
    @IBOutlet weak var numberFavoritesLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    
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
    
    func updateViewsWithCurrentTweet(){
        if let tweet = tweet {
            authorNameLabel.text = tweet.author.name
            authorHandleLabel.text = tweet.author.handle
            tweetTextLabel.text = tweet.fullDescription
            createdAtLabel.text = TweetViewController.dateFormatter.string(from: tweet.createdAtDate)
            authorImageView.setImageWith(tweet.author.profileImageUrl)
            numberTweetsLabel.text = "\(tweet.numberOfRetweets)"
            numberFavoritesLabel.text = "\(tweet.numberOfFavorites)"
        }
    }
    
    @IBAction func onReplyButton(_ sender: Any) {
        
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        User.current!.retweet(tweet!, completion: { (updatedTweet) in
            self.tweet = updatedTweet
            self.updateViewsWithCurrentTweet()
        }) { (error) in
            print(error)
        }
    }
    
    @IBAction func onFavoriteButton(_ sender: Any) {
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
