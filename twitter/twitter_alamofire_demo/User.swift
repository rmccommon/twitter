//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Sierra Klix on 10/8/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import Foundation

class User{
    /*    --Properties--      */
    var name: String
    var screenName: String?
    var profilePic: URL?
    var bannerPic: URL?
    var friendCount: Int?
    var followerCount: Int?
    var userId: Int64?
    var favoriteCount: Int?
    var statusCount: Int?
    
    
    var dictionary: [String: Any]?
    
    
    /*    --Initializers--    */
    
    init(dictionary: [String: Any]){
        self.dictionary = dictionary
        name = dictionary["name"] as! String
        
        if let profile: String = dictionary["profile_image_url_https"] as? String{
            profilePic = URL(string: profile)!
        }
        
        if let banner : String = dictionary["profile_banner_url"] as? String{
            bannerPic = URL(string: banner)!
        }
        
        if let screen = dictionary["screen_name"] as? String{
            self.screenName = screen
        }
        
        friendCount = dictionary["favorite_count"] as? Int
        followerCount = dictionary["followers_count"] as? Int
        statusCount = dictionary["statuses_count"] as? Int
 
        guard let twitid: NSNumber = dictionary["id"] as? NSNumber else{
                print("Twitter Id Error")
                return
        }
        userId = twitid.int64Value
        favoriteCount = dictionary["favourites_count"] as? Int
        
    
    }
    
    private static var _current: User?
    static var current: User?{
    get{
        let defaults = UserDefaults.standard
    if let userData = defaults.data(forKey: "currentUserData"){
    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
    return User(dictionary: dictionary)
    }
    return nil
    }
    
    set(user){
        let defaults = UserDefaults.standard
        if let user = user{
            let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
            defaults.set(data, forKey: "currentUserData")
        }else{
            defaults.removeObject(forKey: "currentUserData")
        }
    }
    }
    
}
