//
//  makeTweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Sierra Klix on 10/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

protocol makeTweetDelegate: class{
    func did(post: Tweet)
}

class makeTweetViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var profImage: UIImageView!
    
    @IBOutlet weak var charsRemaining: UILabel!
    @IBOutlet weak var atName: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetText: UITextView!
    
    var user : User?
    weak var delegate: makeTweetDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user{
            if let profURL = user.profilePic{
                profImage.af_setImage(withURL: profURL)
            }
            usernameLabel.text = user.name
            atName.text = String("@\(user.screenName!)")
        }
        tweetText.delegate = self

        // Do any additional setup after loading the view.
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charLimit = 140
        let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
        charsRemaining.text = String("\(charLimit - newText.count)")
        return newText.count < charLimit
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(_ sender: Any) {
        performSegue(withIdentifier: "timelineSegue", sender: nil)
    }
    
    @IBAction func clickSubmit(_ sender: Any) {
        APIManager.shared.makeTweet(with: tweetText.text!, completion: {(tweet , error) in
            if let error = error{
                print(error.localizedDescription)
            }else if let tweet = tweet{
                self.delegate?.did(post: tweet)
                self.performSegue(withIdentifier: "timelineSegue", sender: nil)
            }
        })
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
