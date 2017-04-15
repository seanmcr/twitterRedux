//
//  TweetCell.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    @IBOutlet weak var profilePicImageView: UIImageView!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeSincePostLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var tweet: Tweet? {
        didSet{
            
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
