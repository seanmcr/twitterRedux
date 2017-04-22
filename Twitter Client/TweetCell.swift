//
//  TweetCell.swift
//  Twitter Client
//
//  Created by Sean McRoskey on 4/14/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    private static var dateComponentsFormatter: DateComponentsFormatter?
    
    @IBOutlet weak var profilePicImageView: UIImageView!

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeSincePostLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweeterHandleLabel: UILabel!
    
    @IBOutlet weak var retweetedByView: UIView!
    var tweet: Tweet! {
        didSet{
            let attributedString = NSMutableAttributedString(
                string: "\(tweet.author!.name!) \(tweet.author.handle!)",
                attributes: [NSFontAttributeName : UIFont.systemFont(ofSize: 15.0)])
            let authorLength = tweet.author.name!.characters.count
            attributedString.addAttributes(
                [NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16.0)],
                range: NSRange(location: 0, length: authorLength))
            attributedString.addAttributes(
                [NSForegroundColorAttributeName : UIColor.lightGray],
                range: NSRange(location: authorLength + 1, length: attributedString.length - authorLength - 1))
            authorLabel.attributedText = attributedString
            
            profilePicImageView.setImageWith(tweet.author.profileImageUrl)
            timeSincePostLabel.text = TweetCell.formatDateSince(tweet.createdAtDate!)
            tweetLabel.text = tweet.fullDescription
            
            if (tweet.retweetedBy != nil){
                retweetedByView.isHidden = false
                retweeterHandleLabel.text = "\(tweet.retweetedBy!.handle!) retweeted"
            } else {
                retweetedByView.isHidden = true
            }
        }
    }
    
    private static func formatDateSince(_ fromDate: Date!) -> String? {
        if (dateComponentsFormatter == nil){
            dateComponentsFormatter = DateComponentsFormatter()
            dateComponentsFormatter!.zeroFormattingBehavior = .dropAll
            dateComponentsFormatter!.allowedUnits = [.day, .hour, .minute]
            dateComponentsFormatter!.maximumUnitCount = 2
            dateComponentsFormatter!.unitsStyle = .abbreviated
        }
        return dateComponentsFormatter!.string(from: fromDate, to: Date())
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profilePicImageView.layer.cornerRadius = 5
        profilePicImageView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
