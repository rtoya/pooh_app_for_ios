import UIKit
import MapKit
//import CoreLocation

// 現在地を取得してmapの中心にする
// startを押したらStopWatchが動く, 文字がstopになる、poohのデータをpostする
// map上にリアルタイムで世界中のpooh情報を表示する
// 世界中のpoohのピンをタップすると詳細情報が表示される
// イイねができる
// stopをおしたらかかった時間を表示、データをpost、評価用のフォームが表示される

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // 地図関連 下のmapViewをMapKitViewと紐付ける
    //var mapView: MKMapView = MKMapView()
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.frame = CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height)
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
        var centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        let span = MKCoordinateSpanMake(30, 30)
        var centerPosition = MKCoordinateRegionMake(centerCoordinate, span)
        self.mapView.setRegion(centerPosition,animated:true)
        
    }
 
    // requestを投げて、poohの情報をgetしてくる
    var poohAnnotations: String =
    "{¥'a¥':{¥'latitude¥': 35.665213, ¥'longitude¥':139.730011}}"

    //var poohJson = JSON.parse(string: poohAnnotations)
    
    @IBAction func startTapped(sender: AnyObject) {
      println("aaaaaaaaaaaaa")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}