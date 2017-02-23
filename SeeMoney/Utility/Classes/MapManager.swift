
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
    
    var currentLocation: CLLocationCoordinate2D?
   // @available(iOS 9.0, *)
    lazy var mapView:MKMapView = {
        
        let map = MKMapView(frame:(UIApplication.shared.keyWindow?.frame)!)
        map.showsUserLocation = true;
        map.userTrackingMode = MKUserTrackingMode.follow
        map.showsBuildings = true
        
        map.mapType = .standard
        map.showsCompass = true
        map.isZoomEnabled = false;
        map.isScrollEnabled = false
        return map

    }()
    //获取授权信息
    func getAuthInfo() {
        if !CLLocationManager.locationServicesEnabled() {
            print("定位没有打开呀")
        }
        
        if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined) {
            if #available(iOS 9.0, *) {
                //self.locationManager?.requestLocation()
                self.locationManager.requestAlwaysAuthorization()
            } else {
                
                // Fallback on earlier versions
            }
            
        }
        self.locationManager.startUpdatingLocation()
    }
    
    
    func getmapView() -> MKMapView {
        return mapView;
    }
    //获取两点距离
    func getDistance(from:CLLocationCoordinate2D, to:CLLocationCoordinate2D) -> Double {
        let lfl = CLLocation(latitude: from.latitude , longitude: to.longitude);
        let tfl = CLLocation(latitude: to.latitude, longitude: to.longitude);
        return lfl.distance(from: tfl);
        
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
            redBagsArr.remove(at: redBagsArr.index(of: redbg)!)
            mapView .removeAnnotation(redbg)
           
        }
    }
    
    //划线
    func drawLine(from:CLLocationCoordinate2D,to:CLLocationCoordinate2D,callBack:@escaping (_ isOK : Bool,_ line:MKPolyline?)->Void) -> Void
    {
        let fromPlacemark = MKPlacemark(coordinate: from, addressDictionary: nil)
        let toPlacemark = MKPlacemark(coordinate: to, addressDictionary: nil)
        let fromeItem = MKMapItem(placemark: fromPlacemark)
        let toItem = MKMapItem(placemark: toPlacemark)
        
        let request = MKDirectionsRequest();
        request.source = fromeItem;
        request.destination = toItem;
        request.requestsAlternateRoutes = true
        request.transportType = MKDirectionsTransportType.walking
        let directions = MKDirections(request:request )
        directions.calculate { (response:MKDirectionsResponse?, error:Error?) in
            if (error == nil) {
                let rout = response?.routes[0];
                self.mapView.add(rout!.polyline)
                callBack(true,rout?.polyline)
                
                
            }else {
                callBack(false, nil);
            }
 
        }
        
        
    }
    //mark - 代理
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first?.coordinate
        if currentLocation != nil {
            print("LocationManagerGetLocation : \(currentLocation?.longitude) \(currentLocation?.latitude)")
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("失败了")
    }
    
    
}
