//
//  MapViewController.swift
//  pooh_app_for_ios
//
//  Created by Toya on 2014/09/27.
//  Copyright (c) 2014年 Toya. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    // マップ
    var mapView: MKMapView = MKMapView()
    
    // 長押しでピン立てできる
    var longtapGesture: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.mapView.frame = CGRectMake(0,20,self.view.bounds.size.width,self.view.bounds.size.height)
        self.mapView.delegate = self
        self.view.addSubview(self.mapView)
        
        var centerCoordinate : CLLocationCoordinate2D = CLLocationCoordinate2DMake(35.665213,139.730011)
        let span = MKCoordinateSpanMake(0.003, 0.003)
        var centerPosition = MKCoordinateRegionMake(centerCoordinate, span)
        self.mapView.setRegion(centerPosition,animated:true)
        
        self.longtapGesture.addTarget(self, action: "longPressed:")
        self.mapView.addGestureRecognizer(self.longtapGesture)
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func longPressed(sender: UILongPressGestureRecognizer){
        
        if(sender.state != .Began){
            return
        }
        var location = sender.locationInView(self.mapView)
        var mapPoint:CLLocationCoordinate2D = self.mapView.convertPoint(location, toCoordinateFromView: self.mapView)
        
        var theRoppongiAnnotation = MKPointAnnotation()
        theRoppongiAnnotation.coordinate  = mapPoint
        theRoppongiAnnotation.title       = "あいむうんこなう"
        theRoppongiAnnotation.subtitle    = "ぶりぶり"
        self.mapView.addAnnotation(theRoppongiAnnotation)
    }

}