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

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    // ストップウォッチ用
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var numericDisplay: UILabel!
    var displayLink: CADisplayLink!
    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
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
    }

    // requestを投げて、poohの情報をgetしてくる
    var poohJSON = JSON.fromURL("http://localhost:3000/poohs")
    /*
    @IBAction func startTapped(sender: AnyObject) {
        if poohJSON.isNull {
            println("nullだよー")
        }else{
            for var num = 0; num < 10; num++ {
                println(poohJSON)
            }
        }
    }
    */
    
    @IBAction func startStopButtonTapped(sender: AnyObject) {
        self.displayLink.paused = !(self.displayLink.paused)
        
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

    func displayLinkUpdate(sender: CADisplayLink) {
        self.lastDisplayLinkTimeStamp = self.lastDisplayLinkTimeStamp + self.displayLink.duration
        let formattedString:String = String(format: "%0.2f", self.lastDisplayLinkTimeStamp)
        self.numericDisplay.text = formattedString;
    }
}