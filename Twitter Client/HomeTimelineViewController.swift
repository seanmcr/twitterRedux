//
//  HomeTimelineViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import ARSLineProgress

protocol TweetTimelineDataSource {
    func getTweets(withIdLessThan maxId: Int?, completion: @escaping ([Tweet]) -> Void, error: @escaping (Error) -> Void)
}

class HomeTimelineViewController: BaseTimelineViewController, TweetTimelineDataSource {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    func getTweets(withIdLessThan maxId: Int?, completion: @escaping ([Tweet]) -> Void, error: @escaping (Error) -> Void) {
        TwitterClient.sharedInstance.getHomeTimelineTweets(withIdLessThan: maxId, completion: completion, failure: error)
    }
}

class MentionsTimelineViewController: BaseTimelineViewController, TweetTimelineDataSource {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    func getTweets(withIdLessThan maxId: Int?, completion: @escaping ([Tweet]) -> Void, error: @escaping (Error) -> Void) {
        TwitterClient.sharedInstance.getMentionTweets(withIdLessThan: maxId, completion: completion, failure: error)
    }
}

class BaseTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NavigateToProfileHandler {

    var delegate: TweetTimelineDataSource!
    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let tweetCellNib = UINib(nibName: "TweetCell", bundle: nil)
        tableView.register(tweetCellNib, forCellReuseIdentifier: "TweetCell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTweets), for: .valueChanged)
        tableView.refreshControl = refreshControl
        refreshTweets()
        refreshControl.beginRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignOut(_ sender: Any) {
        User.current!.logout()
    }
    
    func navigateToProfile(forUser user: User) {
        if let navController = parent as? UINavigationController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profile = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            profile.user = user
            profile.navigationItem.leftBarButtonItem = nil
            navController.pushViewController(profile, animated: true)
        }
    }
    
    @objc private func refreshTweets(){
        delegate.getTweets(withIdLessThan: nil, completion: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.tableView.refreshControl!.endRefreshing()
        }) { (error) in
            ARSLineProgress.showFail()
            self.tableView.refreshControl!.endRefreshing()
        }
    }
    
    private func loadMoreTweets(){
        if (tweets.count > 0){
            let maxId = tweets.max(by: {$0.id > $1.id})!.id
            delegate.getTweets(withIdLessThan: maxId, completion: { (tweets) in
                if (tweets.count > 0){
                    self.tweets.append(contentsOf: tweets)
                    self.tableView.reloadData()
                    self.tableView.refreshControl!.endRefreshing()
                }
            }) { (error) in
                ARSLineProgress.showFail()
                self.tableView.refreshControl!.endRefreshing()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is TweetViewController){
            let tweetViewController = segue.destination as! TweetViewController
            tweetViewController.tweet = (sender as! TweetCell).tweet
        } else if (segue.destination is ProfileViewController){
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.user = sender as! User
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets[indexPath.row]
        cell.navigateToProfileHandler = self
        if (indexPath.row == tweets.count - 1){
            loadMoreTweets()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "TweetSegue", sender: tableView.cellForRow(at: indexPath))
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
