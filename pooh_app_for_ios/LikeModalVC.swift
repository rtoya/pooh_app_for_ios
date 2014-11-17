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
    
    
    var delegate: PoohMapViewController! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orangeColor()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

        
}
