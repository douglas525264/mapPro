//
//  MainMapViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import MapKit
import MBProgressHUD
class MainMapViewController: UIViewController,MKMapViewDelegate {
    
    var currentlocation:CLLocationCoordinate2D?
    var currentredBg:redbagModel?
    var currentLine:MKPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapManager.sharedInstance.getAuthInfo()
        self.view.addSubview(MapManager.sharedInstance.mapView)
        MapManager.sharedInstance.mapView.delegate = self;
        createUI()
        //MKUserLocation
        // Do any additional setup after loading the view.
    }
    func createUI(){
      //  navigationController?.navigationBarHidden = true
    }
    
    //delgate
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
       // userLocation.coordinate
        userLocation.title = "我的位置"
        let center = userLocation.location?.coordinate
        self.currentlocation = center
        if (currentredBg != nil) {
            let dis = MapManager.sharedInstance.getDistance(center!, to: currentredBg!.coordinate)
            if dis < 5 {
                MapManager.sharedInstance.removeBag(self.currentredBg!)
                if (currentLine != nil) {
                    mapView.removeOverlay(currentLine!)
                }
                currentLine = nil
                currentredBg = nil
            }
        }
        RedBagManager.sharedInstance.scanRedbag(center!) { (redbags) in
            if redbags?.count > 0 {
                DXHelper.shareInstance.makeAlert(String(format: "发现%ld个红包",(redbags?.count)!), dur: 1, isShake: true)
                let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
                let region = MKCoordinateRegion(center: center!, span: coordinateSpan)
                mapView.setRegion(region, animated:true)
                MapManager.sharedInstance.addRedbags(redbags!)
                
                
            }
        }
        
    }
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if (annotation .isKindOfClass(redbagModel)) {
          let mapId = "mapID"
            var mv = mapView.dequeueReusableAnnotationViewWithIdentifier(mapId)
            if mv == nil {
                mv = MKAnnotationView(annotation: annotation, reuseIdentifier: mapId)
            }
            let model = annotation as! redbagModel
            mv?.image = model.image
            mv?.canShowCallout = true
            mv?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            return mv
            
            
            
        }
        return nil
    }
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        if (view.annotation!.isKindOfClass(redbagModel)) {
            
            if self.currentLine == nil {
                let alertVc = UIAlertController(title: "提示", message: "我擦，发现一只大红包", preferredStyle: UIAlertControllerStyle.Alert);
                let goActionAction = UIAlertAction(title: "前往", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) in
                    
                    DXHelper.shareInstance.makeAlert("路线规划中", dur: 1, isShake: false)
                    MapManager.sharedInstance .drawLine(self.currentlocation!, to: (view.annotation?.coordinate)!, callBack: { (isOK : Bool, line:MKPolyline?) in
                        if isOK {
                            
                            self.currentLine = line
                        } else {
                            print("路线规划失败了")
                        }
                    })
                })
                let igNoreActionAction = UIAlertAction(title:"忽略", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction) in
                    MapManager.sharedInstance.removeBag(view.annotation as! redbagModel)
                })
                alertVc.addAction(goActionAction)
                alertVc.addAction(igNoreActionAction)
                self.presentViewController(alertVc, animated: true, completion: {
                    
                })
  
            }
            
            
        }
    }
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = RGB(60, g: 150, b: 250, a: 0.8)
        return renderer
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
