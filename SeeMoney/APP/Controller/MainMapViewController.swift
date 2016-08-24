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
class MainMapViewController: UIViewController,MKMapViewDelegate,SlideViewControllerDelegate {
    
    var currentlocation:CLLocationCoordinate2D?
    var currentredBg:redbagModel?
    var currentLine:MKPolyline?
    var mapView:MKMapView?
    lazy var slideVC:SlideViewController = SlideViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapManager.sharedInstance.getAuthInfo()
        self.mapView = MapManager.sharedInstance.mapView
        self.view.addSubview(self.mapView!)
        MapManager.sharedInstance.mapView.delegate = self;
        createUI()
        //test
//        UserManager.shareInstance.register("13520580108", psw: "1234567") { (isOK, userInfo) in
//            
//        }
      //  UserManager.shareInstance.login("18513581292", psw: "123456") { (isOK, userInfo) in
            
    //    }
        //MKUserLocation
        // Do any additional setup after loading the view.
    }
    func createUI(){
        
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Organize, target: self, action:#selector(MainMapViewController.leftBtnClick(_:)))
        self.navigationItem.leftBarButtonItem = leftItem
        self.view .sendSubviewToBack(self.mapView!)
        self.slideVC.delegate = self
        navigationController?.navigationBarHidden = true
    }
    
    @IBOutlet weak var sendBtnClick: UIButton!
    @IBAction func sendAction(sender: AnyObject) {
        
        RedBagManager.sharedInstance.sendRedBag(10) { (isOK) in
            if isOK {
                DXHelper.shareInstance.makeAlert("发送成功", dur: 2, isShake: false)
                let me = UserManager.shareInstance.getMe()
                me.accountNum -= 10;
                UserManager.shareInstance.saveModel(me)
            }
        }
    }
    @IBAction func leftAction(sender: AnyObject) {
        self.slideVC.show(inView:self.view)
    }
    @IBAction func searchBtnCLick(sender: AnyObject) {
    }
    func leftBtnClick(sender:AnyObject) {
        self.slideVC.show(inView:self.view)
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
    func founctionCallBackAtIndex(index: NSInteger) {
        switch index {
        case 5:
            print("请登录")
            if UserManager.shareInstance.getMe().loginStatus == UserLoginStatus.bagStatusUnLogin {
                let mainStory = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                let lgVC = mainStory.instantiateViewControllerWithIdentifier("LoginViewController")
                self.navigationController?.pushViewController(lgVC, animated: true)
            }
            break
        case 0:
            print("点赞去")
            break
        case 1:
            print("钱包")
            let mainStory = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            let lgVC = mainStory.instantiateViewControllerWithIdentifier("MoneyViewController")
            self.navigationController?.pushViewController(lgVC, animated: true)

            break
        case 2:
            print("设置")
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
            break
        case 3:
            print("退出登录")
            let me = UserManager.shareInstance.getMe()
            me.loginStatus = UserLoginStatus.bagStatusUnLogin
            UserManager.shareInstance.saveModel(me)
            break
            
        default:
            break
        }
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
