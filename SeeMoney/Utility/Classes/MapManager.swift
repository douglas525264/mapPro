
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
    
    var redBagsArr = [redbagModel]()
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
    //获取两点距离
    func getDistance(from:CLLocationCoordinate2D, to:CLLocationCoordinate2D) -> Double {
        let lfl = CLLocation(latitude: from.latitude , longitude: to.longitude);
        let tfl = CLLocation(latitude: to.latitude, longitude: to.longitude);
        return lfl.distanceFromLocation(tfl);
        
    }
    //像地图中添加红包
    func addRedbags(redBags:[redbagModel]) -> Void {
        var newAdd = [redbagModel]()
        for redb:redbagModel in redBags {
            if redBagsArr.contains(redb) {
                continue
            }
            redBagsArr.append(redb)
            newAdd.append(redb)
        }
        if newAdd.count > 0 {
            mapView.addAnnotations(newAdd)
        }
    }
    //移除红包
    func removeBag(redbg:redbagModel) -> Void {
        if redBagsArr.contains(redbg) {
            redBagsArr.removeAtIndex(redBagsArr.indexOf(redbg)!)
            mapView .removeAnnotation(redbg)
        }
    }
    
    //划线
    func drawLine(from:CLLocationCoordinate2D,to:CLLocationCoordinate2D,callBack:(isOK:Bool,line:MKPolyline?)->Void) -> Void
    {
        let fromPlacemark = MKPlacemark(coordinate: from, addressDictionary: nil)
        let toPlacemark = MKPlacemark(coordinate: to, addressDictionary: nil)
        let fromeItem = MKMapItem(placemark: fromPlacemark)
        let toItem = MKMapItem(placemark: toPlacemark)
        
        let request = MKDirectionsRequest();
        request.source = fromeItem;
        request.destination = toItem;
        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request:request )
        directions.calculateDirectionsWithCompletionHandler { (response:MKDirectionsResponse?,error:NSError?) in
            if (error == nil) {
                let rout = response?.routes[0];
                self.mapView.addOverlay(rout!.polyline)
                callBack(isOK: true, line: rout?.polyline)

                
            }else {
                callBack(isOK: false, line: nil);
            }
        }
        
        
        
    }
    //mark - 代理
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("失败了")
    }
    
    
}
