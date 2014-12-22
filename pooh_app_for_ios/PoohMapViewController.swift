import UIKit
import MapKit
import QuartzCore
//import CoreLocation

// 現在地を取得してmapの中心にする
// startを押したらStopWatchが動く, 文字がstopになる、poohのデータをpostする
// map上にリアルタイムで世界中のpooh情報を表示する
// 世界中のpoohのピンをタップすると詳細情報が表示される
// イイねができる
// stopをおしたらかかった時間を表示、データをpost、評価用のフォームが表示される

class PoohMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    // ストップウォッチ用
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var numericDisplay: UILabel!
    var displayLink: CADisplayLink!
    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
    // poohinfoをgetしてくる
    var poohInformations = JSON.fromURL("http://localhost:3000/poohs")["poohInfo"]
  
    
    // いいねモーダル
    @IBOutlet var likeModalBtn: UIButton!

    var pooh_flg = 0   //pooh_flg
    
    let evaluateVC = EvaluationVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.frame = CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height)
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        var centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        let span = MKCoordinateSpanMake(30, 30)
        var centerPosition = MKCoordinateRegionMake(centerCoordinate, span)
        self.mapView.setRegion(centerPosition,animated:true)

        self.numericDisplay.text = "0.00"
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:")
        self.displayLink.paused = true;
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
        
        self.getPoohInfo(poohInformations)
        
        likeModalBtn.addTarget(self, action: "showLikeModal:", forControlEvents: .TouchUpInside)
    }

    // poohの情報を取得
    func getPoohInfo(poohInformations: JSON){
        for information in poohInformations {
            var poohId = information.1["pooh_id"]
            var poohLatitude = information.1["latitude"].asDouble!;
            var poohLongitude = information.1["longitude"].asDouble!;
            var poohCoordinate = CLLocationCoordinate2D(latitude: poohLatitude, longitude: poohLongitude)
            var Annotation = MKPointAnnotation()
            Annotation.coordinate  = poohCoordinate
            self.mapView.addAnnotation(Annotation)
           
        }
    }
    
    // startを押下した時の挙動
    @IBAction func startStopButtonTapped(sender: AnyObject) {
        self.displayLink.paused = !(self.displayLink.paused)
    
        var now = NSDate() //started_at, finished_at
        var lat = 0.111111 //latitude
        var lon = 0.222222 //longitude
        
        if pooh_flg == 1 {
          pooh_flg = 0
            self.finishPooh(now)
        } else {
          pooh_flg = 1
            self.startPooh(now)
        }
        
    }

    // ストップウォッチの表示
    func displayLinkUpdate(sender: CADisplayLink) {
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
        self.numericDisplay.text = formattedString;
    }
    
    // likeModalを開く
    func showLikeModal(sender: AnyObject){
      //let likeModalView = LikeModalVC()
      //likeModalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
      //self.presentViewController(likeModalView, animated: true, completion: nil)
    }
    
    @IBAction func unwindToTop(segue: UIStoryboardSegue) {
    }
    
    // うんこ開始時のメソッド
    func startPooh(started_at: NSDate){
        println("うんこするで:\(started_at)")
    }
    
    // うんこ終了時のメソッド
    func finishPooh(finished_at: AnyObject){
        self.presentViewController(self.evaluateVC, animated: true, completion: nil)
    }
    
}