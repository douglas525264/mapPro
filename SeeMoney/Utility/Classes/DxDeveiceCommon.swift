//
//  DxDeveiceCommon.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class DxDeveiceCommon: NSObject {
    
    class func getDeviceUUID()-> String {
        var str = String(describing: UIDevice.current.identifierForVendor?.uuidString)
        str = str.replacingOccurrences(of: "-", with: "")
        return str;
    }
    class func getDeviceImei()-> String {
        return getDeviceUUID();
    }
    class func getVersionName()-> String {
        let infoDic = Bundle.main.infoDictionary
        
        return String(describing: infoDic!["CFBundleDisplayName"]);
    }
    class func getVersionCode()-> String {
        let infoDic = Bundle.main.infoDictionary
        return String(describing: infoDic!["CFBundleVersion"]);
    }
    class func getDeviceCommenInfo()-> String {
        return "";
    }
    class func getDeviceCommonHeader()-> Dictionary<String,AnyObject> {
        var header = Dictionary<String,AnyObject>();
        header["X-IMEI"] = getDeviceImei() as AnyObject?
        header["X-VN"] = getVersionCode() as AnyObject?
        header["X-CHN"] = "i000001" as AnyObject?
        header["X-VC"]  = getVersionCode() as AnyObject?
        let me = UserManager.shareInstance.getMe()
        if (me.token != nil && me.loginStatus == UserLoginStatus.bagStatusHaslogin) {
            header["X-CK"] = me.token as AnyObject?
        }
        let currentPoint = MapManager.sharedInstance.mapView.userLocation.coordinate
        let lat = NSNumber(value: currentPoint.latitude as Double).stringValue
        let lon = NSNumber(value: currentPoint.longitude as Double).stringValue
        header["X-LAT"] = lat as AnyObject?
        header["X-LNT"] = lon as AnyObject?
        return header;
    }
    class func getCurrentLanguage()-> String {
        return "";
    }
}
/*
 
 + (NSString *)getDeviceUUID;
 + (NSString *)getDeviceImei;
 + (NSString *)getVersionName;
 + (NSString *)getVersionCode;
 + (NSString *)getDeviceCommenInfo;
 + (NSMutableDictionary *)getDeviceCommonHeader;
 
 + (BOOL)validatePhone:(NSString *)phone;
 + (NSString *)getLocalStr;
 + (BOOL)isValidatePsd:(NSString *)psd;
 + (NSDictionary *)getDeviceTokenHeader;
 + (NSString *)getDeviceNet;
 + (NSString *)getCurrentLanguage;
 + (NSString *) platformString;

 */
