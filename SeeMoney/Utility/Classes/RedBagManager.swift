//
//  RedBagManager.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import MapKit
class RedBagManager: NSObject {
    static let sharedInstance = RedBagManager()
   lazy  var redbags:[redbagModel] = {
        var arr = [redbagModel]();
//        let redbag = redbagModel(redId: "001", title: "红包", subTitle: "", image: UIImage(named: "redbg2"), coo: CLLocationCoordinate2DMake(39.97633, 116.33900))
//        arr .append(redbag)
        return arr
    }()
    //用于本地检索
    func scanRedbag(location:CLLocationCoordinate2D,finishedBlock:(redbags:[redbagModel]?) -> Void) -> Void {
        
        var resultarr = [redbagModel]()
        for redbag in self.redbags {
           let dis = MapManager.sharedInstance.getDistance(location, to: redbag.coordinate)
            if (dis < 500 && redbag.status == bagStatus.bagStatusUnShow) {
                
               resultarr .append(redbag)
                redbag.status = bagStatus.bagStatusHasShow
            }
           //
        }
        //移除地图距离过远
        for redbag in MapManager.sharedInstance.redBagsArr {
            let dis = MapManager.sharedInstance.getDistance(location, to: redbag.coordinate)
            if (dis > 500) {
                MapManager.sharedInstance.removeBag(redbag)
      
            }

        }
        finishedBlock(redbags: resultarr)
    }
    //发红包
    func sendRedBag(num:Float,finishedBlock:(isOK:Bool) -> Void) -> Void {
        print("sendredBagURL: + \(sendRedbagURL)")
        let location = MapManager.sharedInstance.getmapView().userLocation.coordinate
  
            DXNetWorkTool.sharedInstance.post(sendRedbagURL, body:["t":1,"amount":num,"lat":(location.latitude),"lnt":(location.longitude),"title":"测试红包","size":10], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
                finishedBlock(isOK: true)
                }, fail: { (error:SMError) in
                finishedBlock(isOK: false)
            })
        

        
    }
    func pick(redId:String,type:String,finishedBlock:(isOK:Bool,info:String?) -> Void) {
        
        print("redId : \(redId)")
        
        DXNetWorkTool.sharedInstance.post(pickRedbagURL, body: ["id":redId,"type":1], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            finishedBlock(isOK: true,info: nil)
        }) { (error:SMError) in
            finishedBlock(isOK: false,info: error.des)
        }
    }
    //远程搜索
    func remogteSearch(location:CLLocationCoordinate2D,finishedBlock:(redbags:[redbagModel]?) -> Void) {
        
        let search = String(format: searchredBgURl, location.latitude,location.longitude)
        print("sendredBagURL: + \(search)")
        DXNetWorkTool.sharedInstance.get(search, body:  Dictionary<String, AnyObject>(), header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info : Dictionary<String, AnyObject>?, isOK : Bool, code:Int) in
            
            let arr :[AnyObject] = info!["es"] as! [AnyObject]
            for item  in arr {
                let dic = item as?  Dictionary<String, AnyObject>
                if (dic != nil) {
                    
                    let locationInfo = dic!["loc"] as? Dictionary<String, AnyObject>
                    let type = dic!["t"] as! NSInteger
                    
                    let redbag = redbagModel(redId: dic!["id"] as? String, title: dic!["title"] as? String, subTitle: "", image: UIImage(named: "redbg2"), coo: CLLocationCoordinate2DMake(locationInfo!["lat"] as! CLLocationDegrees, locationInfo!["lnt"] as! CLLocationDegrees));
                    if type == 1 {
                    
                        redbag.bagType = redBagType.redBagTypeMoney
                    } else {
                        redbag.bagType = redBagType.redBagTypeGold
                    
                    }
                    redbag.num = dic!["amount"] as! Double
                    
                    if (!self.redbags.contains(redbag)) {
                    self.redbags .append(redbag)
                    }
                    
                }
            }
            if arr.count > 0 {
            
                self.scanRedbag(location, finishedBlock: finishedBlock)
            }else {
            finishedBlock(redbags: [redbagModel]())
            }
            
            
        }) { (error : SMError) in
            
        }
    }
    
}
