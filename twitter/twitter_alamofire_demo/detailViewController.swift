//
//  detailViewController.swift
//  twitter_alamofire_demo
//
//  Created by Sierra Klix on 10/15/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class detailViewController: UIViewController {
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var atName: UILabel!
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favorButton: UIButton!
    
    @IBOutlet weak var mainText: UILabel!
    
    @IBOutlet weak var createDate: UILabel!
    
    var tweet: Tweet?
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let newtweet = self.tweet, let userLabel = self.user{
            if let picURL = userLabel.profilePic{
                profImage.af_setImage(withURL: picURL)
            }
            atName.text = String("@\(userLabel.screenName ?? "")")
            username.text = userLabel.name
            mainText.text = newtweet.text
            createDate.text = newtweet.createdAtString
            if(newtweet.favorited == true){
                favorButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
            }else{
                favorButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
            }
            favorButton.setTitle("\(newtweet.favoriteCount ?? 0)", for: .normal)
            if(newtweet.retweeted == true){
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            }else{
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
            retweetButton.setTitle("\(newtweet.retweetCount)", for: .normal)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func favorButton(_ sender: Any) {
        if(tweet!.favorited == false){
            APIManager.shared.favoriteIt(self.tweet!, completion: {(post, error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    self.favorButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                }
            })
        }
        
    }
    
    @IBAction func retweetButt(_ sender: Any) {
        if(tweet!.retweeted == false){
            APIManager.shared.retweetIt(self.tweet!, completion: {(post, error) in
                if let error = error{
                    print(error.localizedDescription)
                }else{
                    self.retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
                }
            })
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
