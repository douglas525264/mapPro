//
//  ToolModel.swift
//  SeeMoney
//
//  Created by douglas on 2016/11/23.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
enum ToolType {
    case pickTool
    
}
class ToolModel: NSObject {
    var type  = ToolType.pickTool
    var des:String = "工具"
    var iconUrl:String?
    var price = 0
    var id:String?
}
