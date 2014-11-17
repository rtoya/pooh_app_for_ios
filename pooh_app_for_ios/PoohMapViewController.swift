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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.frame = CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height)
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
        var centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        let span = MKCoordinateSpanMake(30, 30)
        var centerPosition = MKCoordinateRegionMake(centerCoordinate, span)
        self.mapView.setRegion(centerPosition,animated:true)

        // ストップウォッチ用
        // 表示の文字の所を一旦"Are yoy ready?で代替してます"
        self.numericDisplay.text = "0.00"
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:")
        self.displayLink.paused = true;
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
        
        // Map上にAnnotationを表示する
        self.getPoohInfo(poohInformations)
        
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
            Annotation.title = "とおや"
            Annotation.subtitle = "00:00:00"
        }
    }
    
    // startを押下した時の挙動
    @IBAction func startStopButtonTapped(sender: AnyObject) {
        self.displayLink.paused = !(self.displayLink.paused)
        
        // 位置情報、start_at、pooh_flgを送信する
        /*
          func postPoohInfo
        */
        // ボタンの表示を切り替えたい
        var buttonText:String = "Stop"
        if self.displayLink.paused {
            if self.lastDisplayLinkTimeStamp > 0 {
                buttonText = "Resume"
            } else {
                buttonText = "Start"
            }
        }
        self.startStopButton.setTitle(buttonText, forState: UIControlState.Normal)
    }

    // ストップウォッチの表示
    func displayLinkUpdate(sender: CADisplayLink) {
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
        self.numericDisplay.text = formattedString;
    }
    
    
    func showLikeModal(sender: AnyObject){
      let likeModalView = LikeModalVC()
      likeModalView.modalTransitionStyle = UIModalTransitionStyle.CoverVertical
      self.presentViewController(likeModalView, animated: true, completion: nil)
    }
}