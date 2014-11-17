//
//  LikeModalVC.swift
//  pooh_app_for_ios
//
//  Created by Toya on 2014/11/04.
//  Copyright (c) 2014年 Toya. All rights reserved.
//

import UIKit

class LikeModalVC: UIViewController {

    
    @IBOutlet var closeLikeModalBtn: UIButton!  // 戻るボタン
    @IBOutlet var sendLikeBtn: UIButton!        // likeボタン
    
    // ユーザー名ラベル
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var poohTimerLabel: UILabel!
    @IBOutlet var likeNumLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    
    //var delegate: PoohMapViewController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orangeColor()

        // tapしたpoohの情報取得
        var poohInfo = JSON.fromURL("http://localhost:3000/poohs/1")["pooh"]
        
        // ランキングの文字列を表示するために一旦変数に置く
        var name: NSString? = poohInfo[0]["name"].toString()
        var rank: NSString? = poohInfo[0]["rank"].toString()
        var total_poos: NSString? = poohInfo[0]["total_poos"].toString()

        println(userNameLabel)
        
        userNameLabel.text = "aaaaaa"

        
        println(name)
        println(self)
        
        // 表示文字列の変更
        self.placeLabel.text = poohInfo[0]["longitude"].toString()
        self.poohTimerLabel.text = poohInfo[0]["started_at"].toString()
        self.likeNumLabel.text = poohInfo[0]["like_num"].toString()
        self.rankingLabel.text = "\(rank)/\(total_poos)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
}
