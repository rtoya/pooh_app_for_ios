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
    
    
    // tapしたpoohの情報取得
    var poohInfo = JSON.fromURL("http://localhost:3000/poohs/1")["pooh"]
    
    
    //var delegate: PoohMapViewController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orangeColor()

        println(poohInfo[0])
        
        // ランキングの文字列を表示するために一旦変数に置く
        var rank = poohInfo[0]["rank"].toString()
        var total_poos = poohInfo[0]["total_poos"].toString()
        
        // 表示文字列の変更
        userNameLabel.text = poohInfo[0]["name"].toString()
        placeLabel.text = poohInfo[0]["longitude"].toString()
        poohTimerLabel.text = poohInfo[0]["started_at"].toString()
        likeNumLabel.text = poohInfo[0]["like_num"].toString()
        rankingLabel.text = "\(rank)/\(total_poos)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
}
