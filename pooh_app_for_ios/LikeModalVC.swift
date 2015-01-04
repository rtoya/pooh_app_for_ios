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
    
    // host名をグロバル変数として利用
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
    
    var locationManager = LocationManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var poohInfo = JSON.fromURL("\(app._host)/poohs/2")["pooh"]

        userNameLabel.text = poohInfo[0]["name"].toString()
        poohTimerLabel.text = poohInfo[0]["started_at"].toString()
        likeNumLabel.text = poohInfo[0]["like_num"].toString()
        self.rankingLabel.text = poohInfo[0]["rank"].toString() + "/" + poohInfo[0]["total_poos"].toString()
        
        var lat: Double! = poohInfo[0]["latitude"].asDouble
        var long: Double! = poohInfo[0]["longitude"].asDouble
    
        locationManager.reverseGeocodeLocationWithLatLon(latitude: lat, longitude: long) { (reverseGecodeInfo,placemark,error) -> Void in
            if(error != nil){
                println(error)
            }else{
                var administrativeArea = reverseGecodeInfo!["administrativeArea"] as NSString
                var country = reverseGecodeInfo!["country"] as NSString
                var place = "\(administrativeArea), \(country)"
                self.placeLabel.text = place
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendLike(sender: AnyObject) {
        // resの中身を見てロジック切り分け。
        var res = JSON.fromURL("\(app._host)/poohs/1/like")
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
    
}
