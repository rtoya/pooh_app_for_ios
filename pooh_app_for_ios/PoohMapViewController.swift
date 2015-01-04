import UIKit
import MapKit
import QuartzCore
import Alamofire
//import CoreLocation
// 現在地を取得してmapの中心にする
// 文字がstopになる、poohのデータをpostする
// 世界中のpoohのピンをタップすると詳細情報が表示される
// イイねができる

class PoohMapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    // ストップウォッチ用
    @IBOutlet var startStopButton: UIButton!
    @IBOutlet var numericDisplay: UILabel!
    var displayLink: CADisplayLink!
    var lastDisplayLinkTimeStamp: CFTimeInterval!
    
    var app:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate) // host名をglobal変数から呼び出す
    var pooh_flg = 0   //pooh_flg
    var pooh_id: NSInteger!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 現在地の取得
        // ここで現在地を取得できるようにする
        
        // map部分の初期化
        self.mapView.frame = CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height)
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        var centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        let span = MKCoordinateSpanMake(30, 30)
        var centerPosition = MKCoordinateRegionMake(centerCoordinate, span)
        self.mapView.setRegion(centerPosition,animated:true)

        // stopwatch部分の初期化
        self.numericDisplay.text = "0.00"
        self.startStopButton.setTitle("Start", forState: UIControlState.Normal)
        self.displayLink = CADisplayLink(target: self, selector: "displayLinkUpdate:")
        self.displayLink.paused = true;
        self.displayLink.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        self.lastDisplayLinkTimeStamp = self.displayLink.timestamp
        
        // リアルタイムのトイレ情報を取得
        self.getPoohInfo()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // poohの情報を取得
    func getPoohInfo(){
        Alamofire
            .request(.GET, "\(app._host)/poohs")
            .response() {request, response, data, error in
                
                let statusCode = response?.statusCode
                
                if (statusCode == 200){
                    
                    var jsonResult = NSJSONSerialization
                        .JSONObjectWithData(data! as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                    
                    for information in jsonResult["poohInfo"] as NSArray {
                        
                        var poohId = information["pooh_id"]
                        var lat = information["latitude"] as Double
                        var long = information["longitude"]  as Double
                        var poohCoordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
                        var Annotation: CustomMKPointAnnotation = CustomMKPointAnnotation()
                        Annotation.title = information["name"] as String
                        Annotation.pooh_id = "\(poohId)"
                        //Annotation.subtitle = information["name"] as String // 地名でも入れます
                        Annotation.coordinate  = poohCoordinate
                        self.mapView.addAnnotation(Annotation)
                        
                    }
                    
                } else {
                    
                    println("通信エラーが発生しました!!\(statusCode)")
                    
                }

        }
        
    }
    
    // ストップウォッチを押下した時の挙動
    @IBAction func startStopButtonTapped(sender: AnyObject) {
        self.displayLink.paused = !(self.displayLink.paused)
        if pooh_flg == 1 {
          self.finishPooh()
        } else {
          self.startPooh()
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
    func startPooh(){
        var url: String = "\(app._host)/poohs/start"
        let startData = [
            "user_id": "1",
            "latitude": "0.111111",
            "longitude": "0.222222",
            "started_at":"\(NSDate())"
        ]
        
        Alamofire.request(.POST, url, parameters: startData)
            .response() {request, response, data, error in
                var startResult = NSJSONSerialization
                    .JSONObjectWithData(data! as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                self.pooh_id = startResult["pooh_id"] as NSInteger
        }
        self.pooh_flg = 1
    }
    
    // うんこ終了時のメソッド
    func finishPooh(){
        var url: String = "\(app._host)/poohs/finish"
        let finishData = [
            "pooh_id": "\(pooh_id)",
            "finished_at":"\(NSDate())"
        ]

        Alamofire.request(.POST, url, parameters: finishData)
            .response() {request, response, data, error in
                var finishResult = NSJSONSerialization
                    .JSONObjectWithData(data! as NSData, options: NSJSONReadingOptions.MutableContainers, error: nil) as NSDictionary
                
                var evaluateVC = EvaluationVC()
                evaluateVC.poohId = self.pooh_id
                evaluateVC.poohData.append(finishResult)
                self.pooh_flg = 0
                self.numericDisplay.text = "0.00"
                
                self.presentViewController(evaluateVC, animated: true, completion: nil)
        }
    }
    
    // annotationタップ時に表示される吹き出しのカスタマイズ
    func mapViewAnnot(mapViewAnnot: MKMapView!,ViewForAnnotation annotation: MKAnnotation!) ->MKAnnotationView{
        if annotation is MKUserLocation{ /* return nil */ } // 現在地の場合は非表示にしたい
        let reuseId = "pin" //"\(annotation.pooh_id)"
        
        var pinView = mapViewAnnot.dequeueReusableAnnotationViewWithIdentifier(reuseId) as? MKPinAnnotationView
        
        if(pinView == nil){
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinColor = .Red
            pinView!.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIButton
        } else {
            pinView!.annotation = annotation
        }
        return pinView!
    }
}