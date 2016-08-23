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
        var str = String(UIDevice.currentDevice().identifierForVendor?.UUIDString)
        str = str.stringByReplacingOccurrencesOfString("-", withString: "")
        return str;
    }
    class func getDeviceImei()-> String {
        return getDeviceUUID();
    }
    class func getVersionName()-> String {
        let infoDic = NSBundle.mainBundle().infoDictionary
        
        return String(infoDic!["CFBundleDisplayName"]);
    }
    class func getVersionCode()-> String {
        let infoDic = NSBundle.mainBundle().infoDictionary
        return String(infoDic!["CFBundleVersion"]);
    }
    class func getDeviceCommenInfo()-> String {
        return "";
    }
    class func getDeviceCommonHeader()-> Dictionary<String,AnyObject> {
        var header = Dictionary<String,AnyObject>();
        header["X-IMEI"] = getDeviceImei()
        header["X-VN"] = getVersionCode()
        header["X-CHN"] = "i000001"
        header["X-VC"]  = getVersionCode()
        let me = UserManager.shareInstance.getMe()
        if (me.token != nil) {
            header["X-CK"] = me.token
        }
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