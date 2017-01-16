//
//  redbagModel.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import MapKit
enum bagStatus {
    case bagStatusUnShow
    case bagStatusHasShow
    case bagStatusHasOpen
}
enum redBagType:Int {
    case redBagTypeGold = 1
    case redBagTypeMoney = 2
    case redBagTypePlayMoney = 3
}
class redbagModel: NSObject, MKAnnotation{
//    //红包唯一标识
    var redID:String?
    var title:String?
    var subtitle: String?
    var image:UIImage?
    var status = bagStatus.bagStatusUnShow
    //来自某个用户
    var from:UserModel?
    var bagType = redBagType.redBagTypeMoney
    //捡到的列表
    var pickList:Array<Any>?
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? redbagModel {
            return other.redID == self.redID
        }
        return false
    }
    //实际捡到的钱数
    var amount_picked : Double = 0
    var num : Double = 0
    var size : Int = 1
    var sizepicked : Int = 0
    var createTime : Double = NSDate().timeIntervalSince1970
  //  var coordinate: CLLocationCoordinate2D?
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D()
    
    init(redId:String?,title:String?, subTitle:String?,image:UIImage?,coo:CLLocationCoordinate2D!) {
        
        self.redID = redId;
        self.title = title;
        self.subtitle = subTitle;
        self.image = image;
        self.coordinate = coo!;
    }
}
