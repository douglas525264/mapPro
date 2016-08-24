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
        let redbag = redbagModel(redId: "001", title: "红包", subTitle: "", image: UIImage(named: "redbg2"), coo: CLLocationCoordinate2DMake(39.97633, 116.33900))
        arr .append(redbag)
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
        finishedBlock(redbags: resultarr)
    }
    
    func sendRedBag(num:CGFloat,finishedBlock:(isOK:Bool) -> Void) -> Void {
        print("sendredBagURL: + \(sendRedbagURL)")
        let location = MapManager.sharedInstance.currentLocation
        if location != nil {
            DXNetWorkTool.sharedInstance.post(sendRedbagURL, body:["t":1,"amount":20,"lat":(location?.latitude)!,"lnt":(location?.longitude)!,"title":"测试红包","size":num], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>, isOK:Bool, code:Int) in
                finishedBlock(isOK: true)
                }, fail: { (error:NSError) in
                finishedBlock(isOK: false)
            })
        }

        
    }
}
