//
//  NewTweetViewController.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/15/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import ARSLineProgress

class NewTweetViewController: UIViewController {

    @IBOutlet weak var authorImageView: UIImageView!
    
    @IBOutlet weak var authorNameLabel: UILabel!
    
    @IBOutlet weak var authorHandleLabel: UILabel!
    
    @IBOutlet weak var tweetTextField: UITextField!
    
    var isInReplyTo: Tweet? {
        didSet {
            if isInReplyTo != nil {
                self.navigationItem.title = "Reply"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let user = User.current{
            authorImageView.setImageWith(user.profileImageUrl)
            authorHandleLabel.text = user.handle
            authorNameLabel.text = user.name
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
        if let tweetText = tweetTextField.text {
            ARSLineProgress.show()
            if let isInReplyTo = isInReplyTo {
                User.current!.replyTo(isInReplyTo, text: tweetText, completion: { (tweetResponse) in
                    ARSLineProgress.showSuccess()
                    self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    ARSLineProgress.showFail()
                })
            } else {
                User.current!.tweet(tweetText, completion: { (tweetResponse) in
                    ARSLineProgress.showSuccess()
                    self.dismiss(animated: true, completion: nil)
                }, failure: { (error) in
                    ARSLineProgress.showFail()
                })
            }
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
