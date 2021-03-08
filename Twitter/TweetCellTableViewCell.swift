//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by Kuhu Halder on 2/27/21.
//  Copyright © 2021 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var tweetFavorited: Bool = false
    var tweetId: Int = -1
    var tweetRetweeted: Bool = false
    @IBAction func favoriteTweet(_ sender: Any) {
        let willWeFavorite = !tweetFavorited
        if (willWeFavorite){
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("We were not able to favorite tweet: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("We were not able to unfavorite tweet: \(error)")
            })
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool){
        tweetRetweeted = isRetweeted
        if (isRetweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            // retweetButton.isEnabled = false
        }
        else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            // retweetButton.isEnabled = true
        }
    }
    
    
    
    func setFavorite(_ isFavorited: Bool){
        tweetFavorited = isFavorited
        if (tweetFavorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    @IBAction func retweet(_ sender: Any) {
        let willWeRetweet = !tweetRetweeted
        if (willWeRetweet){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("We were not able to retweet tweet: \(error)")
            })
        }
        else{
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (error) in
                print("We were not able to unretweet tweet: \(error)")
            })
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
