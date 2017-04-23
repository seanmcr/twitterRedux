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
    @IBOutlet weak var bgCloudImageView: UIImageView!
    var blurEffect: UIBlurEffect!
    var effectView: UIVisualEffectView!
    var tweets: [Tweet] = []
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if (self.user == nil){
            self.user = User.current
        }
        
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

        blurEffect = UIBlurEffect(style: .light)
        effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = bgCloudImageView.bounds
        effectView.alpha = 0;
        bgCloudImageView.addSubview(effectView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let verticalOffset = scrollView.contentOffset.y
        if (verticalOffset < 0){
            let totalOffset = max(verticalOffset, -30)
            let scale = 1.0 + (-totalOffset / 100.0)
            effectView?.alpha = -totalOffset / 30.0
            bgCloudImageView.transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: 0, y: -totalOffset)
        } else {
            bgCloudImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            effectView?.alpha = 1
        }
    }
    
    @IBAction func didTapSignOut(_ sender: Any) {
        User.current!.logout()
    }
    
    @objc private func refreshTimelineTweets(){
        user.getTimelineTweets(completion: { (tweets) in
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
            user.getTimelineTweets(withIdLessThan: maxId, completion: { (tweets) in
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
            cell.user = user
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if (indexPath.row > 0){
            performSegue(withIdentifier: "TweetSegue", sender: tableView.cellForRow(at: indexPath))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tweetViewController = segue.destination as? TweetViewController {
            tweetViewController.tweet = (sender as! TweetCell).tweet
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
