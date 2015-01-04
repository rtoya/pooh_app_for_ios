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
    var poohData: [NSDictionary] = []//データごと渡したいっす
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println(poohData)
        
        //var poohInfo = JSON.fromURL("\(app._host)/poohs/\(self.poohId)")
        //self.timerTxt.text = "123LIKES!"
        //self.likeTxt.text = "123LIKES!"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
