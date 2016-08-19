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
class redbagModel: NSObject {
//    //红包唯一标识
    var redID:String!
    var title:String?
    var subtitle: String?
    var image:UIImage?
    var coordinate: CLLocationCoordinate2D =  CLLocationCoordinate2D()
    

}
