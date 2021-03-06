//
//  ToolModel.swift
//  SeeMoney
//
//  Created by douglas on 2016/11/23.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
enum ToolType : Int {
    case pickTool = 1
    
}
class ToolModel: NSObject {
    var type  = ToolType.pickTool
    var des:String = "工具"
    var iconUrl:String?
    var price = 0
    var id:String?
    var count = 0
    func config(_ json : Dictionary<String, AnyObject>) {
        self.iconUrl = json["icon"] as! String?
        self.des = json["name"] as! String!
        self.price = json["price"] as! NSInteger!
        self.type = ToolType(rawValue: json["type"] as! Int)!
        self.id =  String(describing: json["id"])
        if json["count"] != nil {
        self.count = json["count"] as! Int
        }
    }
    func config(Json jsonOne : Dictionary<String, AnyObject>) {
        self.iconUrl = jsonOne["tooIconUrl"] as! String?
        self.des = jsonOne["toolName"] as! String!
        
        self.type = ToolType(rawValue: jsonOne["toolId"] as! Int)!
        self.id =  String(describing: jsonOne["toolId"])
        if jsonOne["count"] != nil {
            self.count = jsonOne["count"] as! Int
        }
    }
}
