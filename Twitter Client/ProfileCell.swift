//
//  ProfileCell.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/21/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileCell: UITableViewCell {

    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var numberTweetsLabel: UILabel!
    @IBOutlet weak var numberFollowingLabel: UILabel!
    @IBOutlet weak var numberFollowersLabel: UILabel!
    
    var user: User! {
        didSet {
            userProfileImageView.setImageWith(user.profileImageUrl)
            nameLabel.text = user.name
            handleLabel.text = user.handle
            numberTweetsLabel.text = "\(user.numberOfTweets!)"
            numberFollowingLabel.text = "\(user.numberOfFriends!)"
            numberFollowersLabel.text = "\(user.numberOfFollowers!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
