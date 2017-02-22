//
//  RemoteSever.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import Foundation

let schema = "http://"
let host = "hongbao.api.drqmobile.com/"
//warning : default is POST
let registerURL = schema + host + "v1/user"
let loginURL = schema + host + "v1/user/login"
let sendRedbagURL = schema + "192.168.2.175:9006/"/*"192.168.2.174:9006/"host*/ + "v1/envolope"
//GET  /v1/envolope/pick
let searchredBgURl = schema + "192.168.2.175:9006/" + "v1/envolope?lat=%.14f&lnt=%.14f"
//POST
let pickRedbagURL = schema + host + "v1/envolope/pick"

//User GET
let getUserProfile = schema + host + "v1/user/profile"
//User Put
let resetUserprofile = schema + host + "v1/user/profile"

let uploadAvatarURL = schema + host + "v1/user/profile/icon"
let getAvatarURL = schema + host + "v1/user/profile/icon"
//获取验证码

let getcodeUrl = schema + host + "v1/verification"

//道具相关
//List GET
let toolList = schema + host + "v1/tools/show";
let buytool = schema + host + "v1/tools/buy";
let gettoken = schema + host + "v1/upload/token"

//付款相关
let getNotURL = schema + host + "v1/pay/fql/notify_url"
//?type=1&amount=8 parameter
let getOrderID = schema + host + "v1/order/id"

