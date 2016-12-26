//
//  Commenddefine.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import Foundation
import UIKit
let IS_IOS7 = (UIDevice.current.systemVersion as NSString).doubleValue >= 7.0
let IS_IOS8 = (UIDevice.current.systemVersion as NSString).doubleValue >= 8.0
let IS_IOS9 = (UIDevice.current.systemVersion as NSString).doubleValue >= 9.0
let IS_IOS10 = (UIDevice.current.systemVersion as NSString).doubleValue >= 10.0
let IS_IPAD = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)

let ScreenWidth =  UIApplication.shared.keyWindow?.frame.width
let ScreenHeight =  UIApplication.shared.keyWindow?.frame.height
let bgColor =  RGB(246, g: 246, b: 246, a: 1)
func RGB(_ r:CGFloat, g:CGFloat, b:CGFloat ,a:CGFloat ) -> UIColor {
    
    return UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: a)
}
