//
//  twitCell.swift
//  twitter_alamofire_demo
//
//  Created by Sierra Klix on 10/10/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class twitCell: UITableViewCell {
    @IBOutlet weak var profPic: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var atUser: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetButt: UIButton!
    @IBOutlet weak var likeButt: UIButton!
    
    @IBOutlet weak var timeStamp: UILabel!
    var tweet: Tweet?
    var user: User?
    var indexPath: IndexPath?
    var parent : TimelineViewController?
    
    func updateContent(){
        if let tweet = self.tweet, let user = self.user{
            if let profURL = user.profilePic{
                profPic.af_setImage(withURL: profURL)
            }
            userName.text = user.name
            atUser.text = String("@\(user.screenName!)")
            tweetLabel.text = tweet.text
            timeStamp.text = tweet.createdAtString
            retweetButt.setTitle("\(tweet.retweetCount)", for: .normal)
            likeButt.setTitle("\(tweet.favoriteCount!)", for: .normal)
            if(tweet.favorited! == true) {
                likeButt.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }else{
                likeButt.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
            if(tweet.retweeted == true){
                retweetButt.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }else{
                retweetButt.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func like(_ sender: Any) {
        if(tweet!.favorited == false){
            APIManager.shared.favoriteIt(self.tweet!, completion: {(post, error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    self.parent?.getTweets()
                    self.likeButt.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                }
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any) {
        if(tweet!.retweeted == false){
            APIManager.shared.retweetIt(self.tweet!, completion: {(post, error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    self.parent?.getTweets()
                    self.retweetButt.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                }
            })
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
