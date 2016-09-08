//
//  UserManager.swift
//  SeeMoney
//
//  Created by douglas on 16/8/23.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

protocol UserManagerDlegate : NSObjectProtocol{
    
    func userStatusChange(user: UserModel) -> Void

}
class UserManager: NSObject {

   static let shareInstance = UserManager()
   let UserName = "usernamekey"
   let UserPsw = "userpswkey"
   let UserAccountNum = "useraccountnumkey"
   let UserGoldNum = "usergoldNumKey"
   let UserToken = "usertokenkey"
   let UserGender = "usergenderkey"
   let UserSeeDis = "UserDiskey"
   let UserID = "useridkey"
   let UserStatus = "userstatusKey"
   var delegate:UserManagerDlegate?
    
    func getMe() -> UserModel {
        let me = UserModel()
        let userde = NSUserDefaults.standardUserDefaults()
        var username = userde.objectForKey(UserName);
        if username == nil {
            username = UIDevice.currentDevice().name
        }
        me.username = username as? String
        
        let psw = userde.objectForKey(UserPsw);
        if psw != nil {
           me.psw = psw as? String
        }
        
        let token = userde.objectForKey(UserToken);
        if token != nil {
            me.token = token as? String
        }
        let uid = userde.objectForKey(UserID);
        if uid != nil {
            me.userID = uid as? String
        }

        
        let accountnum = userde.objectForKey(UserAccountNum)
        if accountnum != nil {
            let ac = accountnum as! Double
            
            me.accountNum = ac
        }
        let goldnum = userde.objectForKey(UserGoldNum)
        if goldnum != nil {
            let gc = goldnum as! Double
            
            me.goldCount = gc
        }
        let gender = userde.objectForKey(UserGender)
        if gender != nil {
            let ge = gender as! NSInteger
            
            me.gender = ge
        }
        let sdis = userde.objectForKey(UserSeeDis)
        if gender != nil {
            let sd = sdis as! Double
            
            me.distanceView = sd
        }


        let status = userde.objectForKey(UserStatus)
        if status != nil {
            let sc = status as! NSInteger
            if sc == 1 {
                me.loginStatus = UserLoginStatus.bagStatusHaslogin
            }

           
        }

//        let goldnum = userde.objectForKey(UserGoldNum) as! NSInteger
//        if goldnum > 0 {
//            me.goldCount = goldnum
//        }
//        let status = userde.objectForKey(UserStatus) as! NSInteger
//        if status == 1 {
//            me.loginStatus = UserLoginStatus.bagStatusHaslogin
//        }


        return me
    }
    func saveModel(user:UserModel) {
        let userde = NSUserDefaults.standardUserDefaults()
        if user.username != nil {
            userde .setValue(user.username, forKey: UserName)
        }
        if user.psw != nil {
            userde .setValue(user.psw, forKey: UserPsw)
        }
        if user.token != nil {
            userde .setValue(user.token, forKey: UserToken)
        }
        if user.userID != nil {
            userde .setValue(user.userID, forKey: UserID)
        }
        if user.accountNum > 0{
            userde .setValue(user.accountNum, forKey: UserAccountNum)
        }
        if user.goldCount > 0  {
            
            userde .setValue(user.goldCount, forKey: UserGoldNum)
        }
        if user.gender > 0  {
            
            userde .setValue(user.gender, forKey: UserGender)
        }
        if user.distanceView > 0  {
            
            userde .setValue(user.distanceView, forKey: UserSeeDis)
        }
        if user.loginStatus == UserLoginStatus.bagStatusUnLogin{
            userde.setValue(0, forKey: UserStatus)
        }else {
            userde.setValue(1, forKey: UserStatus)
        }
        userde.synchronize()
        
        self.notStatus()
        
    }
    func register(userName:String, psw:String,resgisterCallBack: (isOK : Bool, userInfo: Dictionary<String,AnyObject>) -> Void) {
        print("registerURL: + \(registerURL)")
        DXNetWorkTool.sharedInstance.post(registerURL, body: ["t":1,"code":userName,"pwd":psw], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            let token = info!["token"];
            let me = self.getMe()
            me.token = token as? String
            me.loginStatus = UserLoginStatus.bagStatusHaslogin
            me.psw = psw
            self.saveModel(me)
           
            resgisterCallBack(isOK: true, userInfo: info!)
        }) { (error:SMError) in
            resgisterCallBack(isOK: false, userInfo:[String:AnyObject]())
        }
    }
    func login(userName:String, psw:String,loginCallBack: (isOK : Bool, userInfo: Dictionary<String,AnyObject>) -> Void) {
        print("loginURL: + \(loginURL)")
        DXNetWorkTool.sharedInstance.post(loginURL, body: ["t":1,"code":userName,"pwd":psw], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            
                let token = info!["token"];
                let me = self.getMe()
                me.token = token as? String
                me.psw = psw
                me.loginStatus = UserLoginStatus.bagStatusHaslogin
            
                let profile = info!["profile"] as? Dictionary<String,AnyObject>
            
                if profile != nil {
                    
                    me.userID = profile!["userid"] as? String
                    me.username = profile!["nick"] as? String
                    me.gender = profile!["gender"] as! NSInteger
                    me.accountNum = profile!["corn"] as! Double
                    me.distanceView = profile!["dis_v"] as! Double
                }
                self.saveModel(me)
                
                loginCallBack(isOK: true, userInfo: info!)

            
        }) { (error:SMError) in
            loginCallBack(isOK: false, userInfo:[String:AnyObject]())
        }
    }

    
    func notStatus() -> Void {
        if self.delegate != nil {
            self.delegate?.userStatusChange(self.getMe())
        }
    }
}

