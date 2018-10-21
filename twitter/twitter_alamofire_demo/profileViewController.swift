//
//  profileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Sierra Klix on 10/20/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class profileViewController: UIViewController {
    
    @IBOutlet weak var progImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var followerCnt: UILabel!
    
    @IBOutlet weak var followingCnt: UILabel!
    
    @IBOutlet weak var tweetCnt: UILabel!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user{
            if let profUrl = user.profilePic{
                progImage.af_setImage(withURL: profUrl)
                usernameLabel.text = user.name
                screennameLabel.text = user.screenName
                followerCnt.text = String("\(user.followerCount!)")
                followingCnt.text = String("\(user.friendCount!)")
                tweetCnt.text = String("\(user.statusCount!)")
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
