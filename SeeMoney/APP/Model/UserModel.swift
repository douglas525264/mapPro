//
//  UserModel.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
enum UserLoginStatus {
    case bagStatusUnLogin
    case bagStatusHaslogin
}
class UserModel: NSObject {

    var username : String?
    var userID : String?
    var iconID : String?
    var avatarUrlStr : String?
    var psw : String?
    var gender = 0
    var accountNum : Double = 100
    var goldCount : Double = 100
    var distanceView : Double = 500
    //ext
    //远程捡取个数
    var pickCount : Double = 1
    //喇叭个数
    var voiceCount : Double = 5
    var loginStatus:UserLoginStatus = UserLoginStatus.bagStatusUnLogin
    var token:String?
    var toolsInfo:Array<Any>?
    
    
    
}
