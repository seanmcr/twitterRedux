//
//  HomeTimelineViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class HomeTimelineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
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
    
    @objc private func refreshTweets(){
        TwitterClient.sharedInstance.getHomeTimelineTweets(completion: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.tableView.refreshControl!.endRefreshing()
        }) { (error) in
            //ARSLineProgress.showFailure()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is TweetViewController){
            let tweetViewController = segue.destination as! TweetViewController
            tweetViewController.tweet = (sender as! TweetCell).tweet
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        cell.tweet = tweets![indexPath.row]
        return cell
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
