import UIKit
import CoreLocation

class LikeModalVC: UIViewController {

    
    @IBOutlet var closeLikeModalBtn: UIButton!  // 戻るボタン
    @IBOutlet var sendLikeBtn: UIButton!        // likeボタン
    
    // 各ラベル
    
    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var placeLabel: UILabel!
    @IBOutlet var poohTimerLabel: UILabel!
    @IBOutlet var likeNumLabel: UILabel!
    @IBOutlet var rankingLabel: UILabel!
    
    //var delegate: PoohMapViewController! = nil
    
    var poohInfo = JSON.fromURL("http://localhost:3000/poohs/1")["pooh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orangeColor()

        // tapしたpoohの情報取得
        // 表示する情報を変数定義（別にいらんけど）
        var name: NSString! = poohInfo[0]["name"].toString()
        var place: NSString! = poohInfo[0]["longitude"].toString()
        var timer: NSString! = poohInfo[0]["started_at"].toString()
        var like_num: NSString! = poohInfo[0]["like_num"].toString()
        var rank: NSString! = poohInfo[0]["rank"].toString()
        var total_poos: NSString! = poohInfo[0]["total_poos"].toString()

        
        // 表示文字列の変更
        userNameLabel.text = name
        self.placeLabel.text = place
        self.poohTimerLabel.text = timer
        self.likeNumLabel.text = like_num
        self.rankingLabel.text = rank + "/" + total_poos
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendLike(sender: AnyObject) {
        // resの中身を見てロジック切り分け。
        var res = JSON.fromURL("http://localhost:3000/poohs/1/like")
        var result = res["result"].toString()
        if result == "true" {
            // like数をここで足す
            self.likeNumLabel.text = res["like_num"].toString()
            // 元の画面に戻すメソッド
            self.dismissViewControllerAnimated(true, completion: nil)
        } else {
            println("ng")
        }
    }
    
    func reverseGeocording(location: CLLocation){
        //CLGeocoder().reverseGeocodeLocation(location, completionHandler:
        
    }
}
