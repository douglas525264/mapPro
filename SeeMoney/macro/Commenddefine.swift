//
//  Commenddefine.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import Foundation
import UIKit
let IS_IOS7 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 8.0
let IS_IOS9 = (UIDevice.currentDevice().systemVersion as NSString).doubleValue >= 9.0

let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.Pad)

func RGB(r:CGFloat, g:CGFloat, b:CGFloat ,a:CGFloat ) -> UIColor {
    
    return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
}