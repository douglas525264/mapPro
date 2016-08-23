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
    var psw : String?
    var accountNum = 0
    var goldCount = 100
    var loginStatus:UserLoginStatus = UserLoginStatus.bagStatusUnLogin
    var token:String?
    
    
}
