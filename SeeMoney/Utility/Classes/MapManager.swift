
//
//  MapManager.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import MapKit
class MapManager: NSObject,CLLocationManagerDelegate {
    
    static let sharedInstance = MapManager()
   lazy var locationManager:CLLocationManager = {
    let ll = CLLocationManager()
    ll.delegate = self
    ll.desiredAccuracy = kCLLocationAccuracyBest
    ll.distanceFilter = 8.0
    return ll
    }()
    lazy var mapView:MKMapView = {
        let map = MKMapView(frame:(UIApplication.sharedApplication().keyWindow?.frame)!)
        map.showsUserLocation = true;
        map.userTrackingMode = MKUserTrackingMode.Follow
        return map

    }()
    //获取授权信息
    func getAuthInfo() {
        if !CLLocationManager.locationServicesEnabled() {
            print("定位没有打开呀")
        }
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined) {
            if #available(iOS 9.0, *) {
                //self.locationManager?.requestLocation()
                self.locationManager.requestAlwaysAuthorization()
            } else {
                
                // Fallback on earlier versions
            }
            
        }
        self.locationManager.stopUpdatingHeading()
    }
    func getmapView() -> MKMapView {
        return mapView;
    }
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("失败了")
    }
    
    
}
