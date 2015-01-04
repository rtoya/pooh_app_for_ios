//
//  EvaluationVC.swift
//  pooh_app_for_ios
//
//  Created by Toya on 2014/11/17.
//  Copyright (c) 2014年 Toya. All rights reserved.
//

import UIKit

class EvaluationVC: UIViewController {
    
    @IBOutlet weak var timerTxt: UILabel!
    @IBOutlet weak var likeTxt: UILabel!
    @IBOutlet weak var typeSelect: UISegmentedControl!
    @IBOutlet weak var chargeSelect: UISegmentedControl!
    
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    var poohId: NSInteger!
    var poohData: [NSDictionary] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // コメントアウトを取ればserverから取得したデータを使用できる
        var like_num = 134 //poohData[0]["like_num"] as NSInteger
        var time = "00:00:10" // poohData[0]["time"] as NSString
        self.timerTxt.text = "\(time)"
        self.likeTxt.text = "\(like_num)LIKES!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 評価をpostするメソッドを作成する
    
}
