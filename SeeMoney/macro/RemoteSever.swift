//
//  RemoteSever.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import Foundation

let schema = "http://"
//warning : default is POST
let registerURL = schema + "hongbao.api.drqmobile.com/v1/user"
let loginURL = schema + "hongbao.api.drqmobile.com/v1/user/login"
let sendRedbagURL = schema + "hongbao.api.drqmobile.com/v1/envolope"
//GET  /v1/envolope/pick
let searchredBgURl = schema + "hongbao.api.drqmobile.com/v1/envolope?lat=%.14f&lnt=%.14f"
//POST
let pickRedbagURL = schema + "hongbao.api.drqmobile.com/v1/envolope/pick"

        