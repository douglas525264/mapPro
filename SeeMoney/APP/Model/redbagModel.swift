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
enum redBagType {
    case redBagTypeGold
    case redBagTypeMoney
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
    override func isEqual(object: AnyObject?) -> Bool {
        if let other = object as? redbagModel {
            return other.redID == self.redID
        }
        return false
    }
    var num : Double = 0
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
