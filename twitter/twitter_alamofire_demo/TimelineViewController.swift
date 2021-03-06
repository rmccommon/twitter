//
//  TimelineViewController.swift
//  twitter_alamofire_demo
//
//  Created by Aristotle on 2018-08-11.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class TimelineViewController: UIViewController, UITableViewDataSource, makeTweetDelegate {
  

    @IBOutlet weak var twitTable: UITableView!
    var tweets : [Tweet] = []
    var refreshControler: UIRefreshControl!
    
    
    @IBAction func didTapLogout(_ sender: Any) {
        APIManager.shared.logout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        twitTable.dataSource = self
        refreshControler = UIRefreshControl()
        refreshControler.addTarget(self, action: #selector(TimelineViewController.getTweets), for: .valueChanged)
        twitTable.insertSubview(refreshControler, at: 0)
        self.getTweets()
        // Do any additional setup after loading the view.
    }
    func getTweets(){
        APIManager.shared.getHomeTimeLine{(tweets, error) in
            if let error = error{
                print(error.localizedDescription)
            }else{
                self.tweets = tweets!
                self.twitTable.reloadData()
                self.refreshControler.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = twitTable.dequeueReusableCell(withIdentifier: "twitCell", for: indexPath) as! twitCell
        let tweet = tweets[indexPath.row]
        cell.tweet = tweet
        cell.user = tweet.user
        cell.indexPath = indexPath
        cell.parent = self as TimelineViewController
        cell.updateContent()
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "detailSegue"){
            if let detControl = segue.destination as? detailViewController{
                if let cell = sender as? twitCell{
                    let tweet = tweets[(cell.indexPath?.row)!]
                    detControl.tweet = tweet
                    detControl.user = tweet.user
                }
            }
        }
        if(segue.identifier == "composeSegue"){
            if let compControl = segue.destination as? makeTweetViewController{
                compControl.user = User.current
                if let destin = segue.destination as? makeTweetViewController{
                    destin.delegate = self
                }
            }
        }
        if(segue.identifier == "profileSegue"){
            if let profControl = segue.destination as? profileViewController{
                profControl.user = User.current
            }
        }
    }
    
    func did(post: Tweet) {
        self.navigationController?.popViewController(animated: true)
            getTweets()
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
