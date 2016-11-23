//
//  UserManager.swift
//  SeeMoney
//
//  Created by douglas on 16/8/23.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

protocol UserManagerDlegate : NSObjectProtocol{
    
    func userStatusChange(_ user: UserModel) -> Void

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
        let userde = UserDefaults.standard
        var username = userde.object(forKey: UserName);
        if username == nil {
            username = UIDevice.current.name
        }
        me.username = username as? String
        
        let psw = userde.object(forKey: UserPsw);
        if psw != nil {
           me.psw = psw as? String
        }
        
        let token = userde.object(forKey: UserToken);
        if token != nil {
            me.token = token as? String
        }
        let uid = userde.object(forKey: UserID);
        if uid != nil {
            me.userID = uid as? String
        }

        
        let accountnum = userde.object(forKey: UserAccountNum)
        if accountnum != nil {
            let ac = accountnum as! Double
            
            me.accountNum = ac
        }
        let goldnum = userde.object(forKey: UserGoldNum)
        if goldnum != nil {
            let gc = goldnum as! Double
            
            me.goldCount = gc
        }
        let gender = userde.object(forKey: UserGender)
        if gender != nil {
            let ge = gender as! NSInteger
            
            me.gender = ge
        }
        let sdis = userde.object(forKey: UserSeeDis)
        if gender != nil {
            let sd = sdis as! Double
            
            me.distanceView = sd
        }


        let status = userde.object(forKey: UserStatus)
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
    func saveModel(_ user:UserModel) {
        let userde = UserDefaults.standard
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
    func updateInfo() -> Void {
        if self.isLogin() {
            
            
            
            DXNetWorkTool.sharedInstance.get(getUserProfile, body: nil, header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
              
                let me = self.getMe()
                let profile = info
                
                if profile != nil {
                    
                    me.userID = profile!["userid"] as? String
                    me.username = profile!["nick"] as? String
                    me.gender = profile!["gender"] as! NSInteger
                    me.accountNum = profile!["account"] as! Double
                    me.goldCount = profile!["corn"] as! Double
                    me.distanceView = profile!["dis_v"] as! Double

                    self.saveModel(me)
                }

                }, fail: { (error:SMError) in
                 //更新失败
            })
        
        } else {
        
            print("您还未登录，不能调取信息");
        }
    }
    func asyToSever(_ paramters : Dictionary<String,AnyObject>, finishedBlock : @escaping (_ isOK :Bool) -> Void ) -> Void {
        if self.isLogin() {
           
            DXNetWorkTool.sharedInstance.put(getUserProfile, body: paramters, header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
                if isOK {
                    finishedBlock(true);
                
                }else {
                finishedBlock(false);
                }
            }, fail: { (error:SMError) in
                //更新失败
                finishedBlock(false);
            })
            
        } else {
            
            print("您还未登录，不能调取信息");
        }
    }
    func register(_ userName:String, psw:String,resgisterCallBack: @escaping (_ isOK : Bool, _ userInfo: Dictionary<String,AnyObject>) -> Void) {
        print("registerURL: + \(registerURL)")
        DXNetWorkTool.sharedInstance.post(registerURL, body: ["t":1 as AnyObject,"code":userName as AnyObject,"pwd":psw as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            let token = info!["token"];
            let me = self.getMe()
            me.token = token as? String
            me.loginStatus = UserLoginStatus.bagStatusHaslogin
            me.psw = psw
            let profile = info!["profile"] as? Dictionary<String,AnyObject>
            
            if profile != nil {
                
                me.userID = profile!["userid"] as? String
                me.username = profile!["nick"] as? String
                me.gender = profile!["gender"] as! NSInteger
                me.accountNum = profile!["account"] as! Double
                me.goldCount = profile!["corn"] as! Double
                me.distanceView = profile!["dis_v"] as! Double
            }
            
            self.saveModel(me)
            self.sendTag()
           
            resgisterCallBack(true, info!)
        }) { (error:SMError) in
            resgisterCallBack(false, [String:AnyObject]())
        }
    }
    
    func login(_ userName:String, psw:String,loginCallBack: @escaping (_ isOK : Bool, _ userInfo: Dictionary<String,AnyObject>) -> Void) {
        print("loginURL: + \(loginURL)")
        DXNetWorkTool.sharedInstance.post(loginURL, body: ["t":1 as AnyObject,"code":userName as AnyObject,"pwd":psw as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            
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
                    me.accountNum = profile!["account"] as! Double
                    me.goldCount = profile!["corn"] as! Double
                    me.distanceView = profile!["dis_v"] as! Double
                }
            
                self.saveModel(me)
                self.sendTag()
                loginCallBack(true, info!)
            
            
        }) { (error:SMError) in
            loginCallBack(false, [String:AnyObject]())
        }
    }

    func sendTag() -> Void {
        let me = self.getMe()
        var hasSet = Set<String>()
        hasSet.insert("beijing")
        
        JPUSHService .setTags(hasSet, aliasInbackground: me.userID)
    }
    func notStatus() -> Void {
        if self.delegate != nil {
            self.delegate?.userStatusChange(self.getMe())
        }
    }
    
    func isLogin() -> Bool {
        let me = self.getMe()
        if me.loginStatus == UserLoginStatus.bagStatusHaslogin{
            return true
        }
        return false
    }
}

