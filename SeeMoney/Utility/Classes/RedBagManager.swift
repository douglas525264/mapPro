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
    
    var searchDis : Double = 500
    lazy  var redbags:[redbagModel] = {
        var arr = [redbagModel]();
//        let redbag = redbagModel(redId: "001", title: "红包", subTitle: "", image: UIImage(named: "redbg2"), coo: CLLocationCoordinate2DMake(39.97633, 116.33900))
//        arr .append(redbag)
        return arr
    }()
    //用于本地检索
    func scanRedbag(_ location:CLLocationCoordinate2D,finishedBlock:(_ redbags:[redbagModel]?) -> Void) -> Void {
        
        var resultarr = [redbagModel]()
        for redbag in self.redbags {
           let dis = MapManager.sharedInstance.getDistance(from: location, to: redbag.coordinate)
            if (dis < searchDis && redbag.status == bagStatus.bagStatusUnShow) {
                
               resultarr .append(redbag)
                redbag.status = bagStatus.bagStatusHasShow
            }
           //
        }
        //移除地图距离过远
        for redbag in MapManager.sharedInstance.redBagsArr {
            let dis = MapManager.sharedInstance.getDistance(from: location, to: redbag.coordinate)
            if (dis > searchDis) {
                MapManager.sharedInstance.removeBag(redbg: redbag)
      
            }

        }
        finishedBlock(resultarr)
    }
    //发红包
    func sendRedBag(_ num:Float,_ size : Int ,_ paytype : Int ,finishedBlock:@escaping (_ isOK:Bool) -> Void) -> Void {
        print("sendRedBag: + \(sendRedbagURL)")
        let location = MapManager.sharedInstance.getmapView().userLocation.coordinate
        
        DXNetWorkTool.sharedInstance.post(sendRedbagURL, body:["type":1 as AnyObject,"paytype":paytype as AnyObject,"size" : size as AnyObject,"amount":num as AnyObject,"lat":(location.latitude as AnyObject),"lnt":(location.longitude as AnyObject),"title":"测试红包" as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
                finishedBlock(true)
                }, fail: { (error:SMError) in
                finishedBlock(false)
            })
        

        
    }
    func sendRedBag(_ num:Float,_ size : Int ,_ paytype : Int, type : redBagType ,title : String, subType : Int,finishedBlock:@escaping (_ isOK:Bool) -> Void) -> Void {
        print("sendRedBag: + \(sendRedbagURL)")
        let location = MapManager.sharedInstance.getmapView().userLocation.coordinate
        
        DXNetWorkTool.sharedInstance.post(sendRedbagURL, body:["type":type.rawValue as AnyObject,"paytype" : paytype as AnyObject,"size" : size as AnyObject,"amount":num as AnyObject,"lat":(location.latitude as AnyObject),"lnt":(location.longitude as AnyObject),"title":title as AnyObject, "subtype" : subType as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            finishedBlock(true)
        }, fail: { (error:SMError) in
            finishedBlock(false)
        })
        
        
        
    }

    func pick(_ redId:String,type:redBagType,finishedBlock:@escaping (_ isOK:Bool,_ msg:String?,_ info:Dictionary<String, AnyObject>?) -> Void) {
        
        print("redId : \(redId)")
        
        DXNetWorkTool.sharedInstance.post(pickRedbagURL, body: ["id":redId as AnyObject,"type":type.rawValue as AnyObject] , header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            
            finishedBlock(true,nil,info)
        }) { (error:SMError) in
            finishedBlock(false,error.des,nil)
        }
    }
    //远程搜索
    func remogteSearch(_ location:CLLocationCoordinate2D,finishedBlock:@escaping (_ redbags:[redbagModel]?) -> Void) {
        
        let search = String(format: searchredBgURl, location.latitude,location.longitude)
        print("searchRedBag: + \(search)")
        DXNetWorkTool.sharedInstance.get(search, body:  Dictionary<String, AnyObject>(), header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info : Dictionary<String, AnyObject>?, isOK : Bool, code:Int) in
            
            let a = info!["es"] as? [AnyObject]
            let b = info!["cs"] as? [AnyObject]
            if a != nil {
                let arr :[AnyObject] = info!["es"] as! [AnyObject]
                for item  in arr {
                    let dic = item as?  Dictionary<String, AnyObject>
                    if (dic != nil) {
                        
                        let locationInfo = dic!["loc"] as? Dictionary<String, AnyObject>
                        // let type = dic!["type"] as! NSInteger
                        
                        let redbag = redbagModel(redId: dic!["id"] as? String, title: dic!["title"] as? String, subTitle: "", image: UIImage(named: "ar_normal_envelope"), coo: CLLocationCoordinate2DMake(locationInfo!["lat"] as! CLLocationDegrees, locationInfo!["lnt"] as! CLLocationDegrees));
                        redbag.bagType = redBagType.redBagTypeMoney
                        redbag.num = dic!["amount"] as! Double
                        redbag.pickList = dic?["pickInfos"] as? Array<Any>
                        if (!self.redbags.contains(redbag)) {
                            self.redbags .append(redbag)
                        }
                        
                    }
                }

            }
            
            
            if b != nil {
            
                let cArr :[AnyObject] = info!["cs"] as! [AnyObject]
                for item  in cArr {
                    let dic = item as?  Dictionary<String, AnyObject>
                    if (dic != nil) {
                        
                        let locationInfo = dic!["loc"] as? Dictionary<String, AnyObject>
                        let type = 0
                        var title = dic?["title"]
                        if title != nil {
                            
                            
                        } else {
                            title = "" as AnyObject?
                        }
                        let redbag = redbagModel(redId: dic!["id"] as? String, title: title as? String , subTitle: "", image: UIImage(named: "ar_normal_envelope"), coo: CLLocationCoordinate2DMake(locationInfo!["lat"] as! CLLocationDegrees, locationInfo!["lnt"] as! CLLocationDegrees));
                        /*    if type == 1 {
                         
                         redbag.bagType = redBagType.redBagTypeMoney
                         } else {*/
                        redbag.bagType = redBagType.redBagTypeGold
                        
                        // }
                        redbag.num = dic!["amount"] as! Double
                        
                        if (!self.redbags.contains(redbag)) {
                            self.redbags .append(redbag)
                        }
                        
                    }
                }

            }
            if self.redbags.count > 0 {
            
                self.scanRedbag(location, finishedBlock: finishedBlock)
            }else {
            finishedBlock([redbagModel]())
            }
            
            
        }) { (error : SMError) in
            finishedBlock([redbagModel]())
        }
    }
    
}
