//
//  ProfileViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/21/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import ARSLineProgress

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        refreshControl.addTarget(self, action: #selector(refreshTimelineTweets), for:.valueChanged)
        tableView.refreshControl = refreshControl
        refreshControl.beginRefreshing()
        refreshTimelineTweets()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        User.current!.logout()
    }
    
    @objc private func refreshTimelineTweets(){
        User.current?.getTimelineTweets(completion: { (tweets) in
            self.tweets = tweets
            self.tableView.reloadData()
            self.tableView.refreshControl!.endRefreshing()
        }) { (error) in
            ARSLineProgress.showFail()
        }
    }
    
    private func getNextTimelineTweets(){
        if (tweets.count > 0){
            let maxId = tweets.max(by: {$0.id > $1.id})!.id
            User.current?.getTimelineTweets(withIdLessThan: maxId, completion: { (tweets) in
                self.tweets.append(contentsOf: tweets)
                self.tableView.reloadData()
                self.tableView.refreshControl!.endRefreshing()
            }) { (error) in
                ARSLineProgress.showFail()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 + tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell") as! ProfileCell
            cell.user = User.current
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
            cell.tweet = tweets[indexPath.row - 1]
            if (indexPath.row == tableView.numberOfRows(inSection: 0) - 1){
                getNextTimelineTweets()
            }
            return cell
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
