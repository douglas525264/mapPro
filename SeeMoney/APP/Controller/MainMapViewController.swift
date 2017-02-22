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
import Qiniu
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class MainMapViewController: UIViewController,MKMapViewDelegate,SlideViewControllerDelegate {
    
    @IBOutlet weak var headerView: UIView!
    var currentlocation:CLLocationCoordinate2D?
    var currentredBg:redbagModel?
    var currentLine:MKPolyline?
    var mapView:MKMapView?
    lazy var slideVC:SlideViewController = SlideViewController()
    var redVC :OpenRedBagViewController?
    var lastRefreashTime:Date?
    var timer:Timer?
    var hasSearch = false
    var aplicationInBg : Bool = false
    var fetchDis:Double = 100
    static var shareInstance:MainMapViewController?
    lazy var nav1 = DXNavgationBar.getNav("探包宝")
    var currentCircle: MKCircle?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MapManager.sharedInstance.getAuthInfo()
        self.mapView = MapManager.sharedInstance.mapView
        self.mapView?.frame = self.view.bounds
        

        self.view.addSubview(self.mapView!)
        MapManager.sharedInstance.mapView.delegate = self;

        self.timer =  Timer.scheduledTimer(timeInterval: 3*60*60, target: self, selector:  #selector(MainMapViewController.bgRefreash), userInfo: nil, repeats: true)
        self.timer?.fire()
        MainMapViewController.shareInstance = self;
        createUI()
        NotificationCenter.default.addObserver(self, selector: #selector(MainMapViewController.appEnterForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(MainMapViewController.appBecomeActive), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        
         let stap = UITapGestureRecognizer(target: self, action: #selector(MainMapViewController.changeSeeDis))
        stap.numberOfTapsRequired = 12
        
        let ftap = UITapGestureRecognizer(target: self, action: #selector(MainMapViewController.changeFetchDis))
        ftap.numberOfTapsRequired = 13
        ftap.numberOfTouchesRequired = 2
        self.headerView.addGestureRecognizer(stap)
        self.headerView.addGestureRecognizer(ftap)
        self.headerView.isHidden = true;
  
        if (UserManager.shareInstance.isLogin()) {
            PayManager.shareInstance.getMyNotURL();
            UserManager.shareInstance.updateInfo()
        }


    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if self.slideVC.isShow {
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        } else {
           UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
    }
    func appEnterForeground() -> Void {
        aplicationInBg = true
        
    }
    func appBecomeActive() -> Void {
        aplicationInBg = false
    }

    func bgRefreash() -> Void {
        if self.currentlocation != nil {
          self.searchRedBag(true)
            hasSearch = true
        }
        
    }

    func createUI(){
        self.view.addSubview(self.nav1);
        self.nav1.titlelable.font = UIFont.boldSystemFont(ofSize: 17)
       // let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.organize, target: self, action:#selector(MainMapViewController.leftBtnClick(_:)))
        let avatarBtn = UIButton(frame: CGRect(x: 10, y: 0, width: 30, height: 30))
        avatarBtn.addTarget(self, action: #selector(MainMapViewController.leftBtnClick(_:)), for: UIControlEvents.touchUpInside)
        avatarBtn.setImage(UIImage(named :"tab_myinfo_icon"), for: UIControlState.normal)
        let leftItem = UIBarButtonItem(customView: avatarBtn)
        self.nav1.leftItems = [leftItem]
        self.view .sendSubview(toBack: self.mapView!)
        self.slideVC.delegate = self
        navigationController?.isNavigationBarHidden = true
        self.closeBtn.isHidden = true
        
    }
    
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var sendBtnClick: UIButton!
    
    
    @IBAction func sendAction(_ sender: AnyObject) {
        
        
        let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
        let sendVC = mainStory.instantiateViewController(withIdentifier: "SendBagTableViewController") as! SendBagTableViewController
        sendVC.payCallBack = {(_ payStatus : CEPaymentStatus) -> () in
            if payStatus == CEPaymentStatus.payResultSuccess {
            
                self.searchRedBag(true)
            }
        }
        let nav = UINavigationController(rootViewController: sendVC)
        self.present(nav, animated: true) { 
            
        };
        
        
       /* let alertVc = UIAlertController(title: "提示", message: "发红包", preferredStyle: UIAlertControllerStyle.alert);
        alertVc .addTextField { (text:UITextField) in
            text.placeholder = "金额"
            text.isSecureTextEntry = false
            text.keyboardType = UIKeyboardType.numberPad
        }
        let sureAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            let textFiled = alertVc.textFields?.first
            if textFiled?.text != nil {
            let num = Float((textFiled?.text)!)
            
            RedBagManager.sharedInstance.sendRedBag(num!,10) { (isOK) in
                if isOK {
                    DXHelper.shareInstance.makeAlert("发送成功", dur: 2, isShake: false)
                    let me = UserManager.shareInstance.getMe()
                    me.accountNum -= 10;
                    
                    UserManager.shareInstance.saveModel(me)
                    self.searchRedBag(true)
                    UserManager.shareInstance.updateInfo();
                }
            }
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            
        }
        alertVc.addAction(sureAction)
        alertVc.addAction(cancelAction)
        self.present(alertVc, animated: true, completion: {
            
        })*/
    }
    
    func changeSeeDis() -> Void {
        let alertVc = UIAlertController(title: "提示", message: "修改可见距离", preferredStyle: UIAlertControllerStyle.alert);
        alertVc .addTextField { (text:UITextField) in
            text.placeholder = "距离:m"
            text.isSecureTextEntry = false
            text.keyboardType = UIKeyboardType.numberPad
        }
        let sureAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            let textFiled = alertVc.textFields?.first
            if textFiled?.text != nil {
            let num = Double(((textFiled?.text))!)
            
            RedBagManager.sharedInstance.searchDis = num!
            }
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            
        }
        alertVc.addAction(sureAction)
        alertVc.addAction(cancelAction)
        self.present(alertVc, animated: true, completion: {
            
        })

    }
    
    
    func changeFetchDis() -> Void {
        let alertVc = UIAlertController(title: "提示", message: "修改抓取距离", preferredStyle: UIAlertControllerStyle.alert);
        alertVc .addTextField { (text:UITextField) in
            text.placeholder = "距离:m"
            text.isSecureTextEntry = false
            text.keyboardType = UIKeyboardType.numberPad
        }
        let sureAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            let textFiled = alertVc.textFields?.first
            if textFiled?.text != nil {
                let num = Double(((textFiled?.text))!)
                
                self.fetchDis = num!
            }
            
        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            
        }
        alertVc.addAction(sureAction)
        alertVc.addAction(cancelAction)
        self.present(alertVc, animated: true, completion: {
            
        })
        

    }
    @IBAction func closeAction(_ sender: AnyObject) {
        let alertVc = UIAlertController(title: "提示", message: "确定取消导航吗", preferredStyle: UIAlertControllerStyle.alert);
        let sureAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            if (self.currentLine != nil) {
                self.mapView!.remove(self.currentLine!)
            }
            self.currentLine = nil
            self.currentredBg = nil
            self.closeBtn.isHidden = true

        }
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.default) { (ac:UIAlertAction) in
            
        }
        alertVc.addAction(sureAction)
        alertVc.addAction(cancelAction)
        self.present(alertVc, animated: true, completion: {
            
        })

        
    }
    @IBAction func leftAction(_ sender: AnyObject) {
        self.slideVC.show(inView:self.view)
    }
    @IBAction func searchBtnCLick(_ sender: AnyObject) {
        self.searchRedBag(false)
    }
    
    func searchRedBag(_ isInBagGround:Bool){
        var hud:MBProgressHUD?
        if !isInBagGround {
           hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
            hud!.labelText = "搜索中,请耐心等待..."
            hud!.mode = MBProgressHUDMode.customView
            hud!.removeFromSuperViewOnHide = true

        }
        
        RedBagManager.sharedInstance.remogteSearch(self.currentlocation!) { (redbags) in
            if !isInBagGround {hud!.hide(true)}
            
            if redbags?.count > 0 {
                if self.aplicationInBg {
                    //本地通知
    
                    let not = UILocalNotification()
                    let pushDate = Date(timeIntervalSinceNow: 1)
                    not.fireDate = pushDate
                    not.timeZone = TimeZone.current
                    not.soundName = UILocalNotificationDefaultSoundName
                    not.alertBody = String(format: "发现%ld个红包",(redbags?.count)!)
                    UIApplication.shared.scheduleLocalNotification(not)
                }
                DXHelper.shareInstance.makeAlert(String(format: "发现%ld个红包",(redbags?.count)!), dur: 1, isShake: true)
                MapManager.sharedInstance.addRedbags(redBags: redbags!)
                
                
            }else {
                DXHelper.shareInstance.makeAlert("在您附近未发现红包，请随处走走", dur: 1, isShake: true)
            }
            
        }

    
    }
    func leftBtnClick(_ sender:AnyObject) {
        self.slideVC.show(inView:self.view)
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
    }
    //delgate
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        if currentCircle != nil {
        
            self.mapView?.remove(self.currentCircle!)
        }
        self.currentCircle = MKCircle(center: userLocation.coordinate, radius: 500)
        self.mapView?.add(self.currentCircle!)
        print("mapView : \(userLocation.coordinate.longitude) \(userLocation.coordinate.latitude)")
       // userLocation.coordinate
        userLocation.title = "我的位置"
        let center = userLocation.location?.coordinate
        self.currentlocation = center
        if !hasSearch {
            self.bgRefreash()
        }
        if (currentredBg != nil) {
            
           let res = self.needGetRedbag()
            if res {
                print("get OK")
            } else {
                print("get false")
            }
        }
        RedBagManager.sharedInstance.scanRedbag(center!) { (redbags) in
            if redbags?.count > 0 {
                DXHelper.shareInstance.makeAlert(String(format: "发现%ld个红包",(redbags?.count)!), dur: 1, isShake: true)
                let coordinateSpan = MKCoordinateSpan(latitudeDelta: 0.0005, longitudeDelta: 0.0005)
                let region = MKCoordinateRegion(center: center!, span: coordinateSpan)
                mapView.setRegion(region, animated:true)
                MapManager.sharedInstance.addRedbags(redBags: redbags!)
                
                
            }
        }
        
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        if (annotation .isKind(of: redbagModel.self)) {
          let mapId = "mapID"
            var mv = mapView.dequeueReusableAnnotationView(withIdentifier: mapId)
            if mv == nil {
                mv = MKAnnotationView(annotation: annotation, reuseIdentifier: mapId)
            }
            let model = annotation as! redbagModel
            mv?.image = model.image
            
            //mv?.canShowCallout = true
            mv?.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            return mv
            
            
            
        }
        return nil
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if (view.annotation!.isKind(of: redbagModel.classForCoder())) {
            
            
             self.currentredBg = view.annotation as? redbagModel
            if !self.needGetRedbag() {
                
            if self.currentLine == nil {
                let alertVc = UIAlertController(title: "提示", message: "我擦，发现一只大红包", preferredStyle: UIAlertControllerStyle.alert);
                let goActionAction = UIAlertAction(title: "前往", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
                    
                    
                   
                    
                    let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow, animated: true)
                    hud?.labelText = "路线规划中..."
                    hud?.mode = MBProgressHUDMode.customView
                    hud?.removeFromSuperViewOnHide = true
                   // DXHelper.shareInstance.makeAlert("路线规划中...", dur: 1, isShake: false)
                    MapManager.sharedInstance .drawLine(from: self.currentlocation!, to: (view.annotation?.coordinate)!, callBack: { (isOK : Bool, line:MKPolyline?) in
                        if isOK {
                            self.closeBtn.isHidden = false
                            self.currentLine = line
                            hud?.hide(true)
                            DXHelper.shareInstance.makeAlert("进入导航模式，点击左上角X关闭导航" , dur: 2, isShake: false)
                            
                        } else {
                            hud?.hide(true)
                            print("路线规划失败了,请稍后重试~")
                        }
                    })
                    
                })
                let igNoreActionAction = UIAlertAction(title:"忽略", style: UIAlertActionStyle.default, handler: { (action:UIAlertAction) in
                    MapManager.sharedInstance.removeBag(redbg: view.annotation as! redbagModel)
                })
                alertVc.addAction(goActionAction)
                alertVc.addAction(igNoreActionAction)
                self.present(alertVc, animated: true, completion: {
                    
                })
  
                }else {
                DXHelper.shareInstance.makeAlert("您已经处于导航模式中。。。" , dur: 2, isShake: false)
                }
            }
            
            
        }else {
        
           
        }
    }
    func needGetRedbag() -> Bool{
        let dis = MapManager.sharedInstance.getDistance(from: self.currentlocation!, to: currentredBg!.coordinate)
        if dis < fetchDis {
            
            let story = UIStoryboard(name: "Main", bundle: Bundle.main)
            let redVC = story.instantiateViewController(withIdentifier: "OpenRedBagViewController")
            self.redVC = redVC as? OpenRedBagViewController
            if self.redVC != nil{
                self.redVC?.parentVc = self
                self.redVC?.redBag = self.currentredBg
                self.redVC?.show(inView: self.view)
            }
            currentLine = nil
            currentredBg = nil
            return true
        }
        return false

    }
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        
        if overlay .isKind(of: MKCircle.classForCoder()){
            
            let circleView = MKCircleRenderer(overlay: overlay)
            circleView.fillColor = .cyan
            circleView.strokeColor = .yellow
            circleView.lineWidth = 2
            circleView.alpha = 0.1
            return circleView
        
        } else {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.lineWidth = 5.0
        renderer.strokeColor = RGB(60, g: 150, b: 250, a: 0.8)
        return renderer
        }
        
    }
    
    func founctionCallBackAtIndex(_ index: NSInteger) {
        switch index {
        case 5:
            print("请登录")
            if UserManager.shareInstance.getMe().loginStatus == UserLoginStatus.bagStatusUnLogin {
                let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
                let lgVC = mainStory.instantiateViewController(withIdentifier: "LoginViewController")
                self.navigationController?.pushViewController(lgVC, animated: true)
            }else {
            
                
            }
            break
        case 0:
            print("点赞去")
            break
        case 1:
            print("钱包")
            let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
            let lgVC = mainStory.instantiateViewController(withIdentifier: "MoneyViewController")
            self.navigationController?.pushViewController(lgVC, animated: true)

            break
        case 2:
            print("设置")
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
            break
        case 3:
            print("道具")
            self.navigationController?.pushViewController(ToolListViewController(), animated: true)
            break
        case 4:
            print("退出登录")
            break
            
        default:
            break
        }
    }
    func push(toVC vc: UIViewController, animated:Bool) {
        self.navigationController?.pushViewController(vc, animated: animated);
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
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
