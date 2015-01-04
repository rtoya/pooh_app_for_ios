//
//  EvaluationVC.swift
//  pooh_app_for_ios
//
//  Created by Toya on 2014/11/17.
//  Copyright (c) 2014年 Toya. All rights reserved.
//

import UIKit
import Alamofire

class EvaluationVC: UIViewController {
    
    @IBOutlet weak var timerTxt: UILabel!
    @IBOutlet weak var likeTxt: UILabel!
    @IBOutlet weak var typeSelect: UISegmentedControl!
    @IBOutlet weak var chargeSelect: UISegmentedControl!
    
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    var poohId: NSInteger!
    var poohData: [ NSObject : AnyObject ] = [ : ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // コメントアウトを取ればserverから取得したデータを使用できる
        var like_num = poohData["like_num"] as NSInteger
        var time = poohData["time"] as NSString
                
        self.timerTxt.text! = "\(time)"
        self.likeTxt.text! = "\(like_num)LIKES!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 評価をpostするメソッドを作成する
    
    @IBAction func saveEvaluation(sender: AnyObject) {
        poohId = 1
        var toiletTypeIdx = self.typeSelect.selectedSegmentIndex     // 0が公共
        var toiletChargeIdx = self.chargeSelect.selectedSegmentIndex // 0が無料
        var url: String = "\(app._host)/toilet/evaluate/\(poohId)"
        let evalResult = [
            "pooh_id": "\(poohId)",
            "user_id": "1", //あとで変更
            "type": "\(toiletTypeIdx)",
            "charge": "\(toiletChargeIdx)",
            "cleanliness":"5" // uiを変更して反映する
        ]
        
        Alamofire.request(.POST, url, parameters: evalResult)
            .response() {request, response, data, error in
                var startResult = NSJSONSerialization
                    .JSONObjectWithData(data! as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                println(startResult)
        }
        
    }
    
    
}
