//
//  ToolManager.swift
//  SeeMoney
//
//  Created by douglas on 2016/11/23.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class ToolManager: NSObject {
    static let shareInstance = ToolManager()
    
    func getToolList(_ finishedBlock : @escaping(_ result : Array<ToolModel>?) -> Void) -> Void {
        
        DXNetWorkTool.sharedInstance.get(toolList, body: nil, header:  DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            var resultArr = Array<ToolModel>()
            if let toolsArr : [Dictionary<String, Any>] = info!["tools"] as! [Dictionary<String, Any>]? {
            
                for item in toolsArr {
                    
                    let toolM = ToolModel()
                    toolM.config(item as Dictionary<String, AnyObject>)
                    resultArr.append(toolM)
                }
            }
            
            finishedBlock(resultArr)
        
            
            
            
        }) { (error:SMError) in
            finishedBlock(Array<ToolModel>())
        }
    }
    func buyTool(_ type:ToolType, _ count : Int ,finishedBlock : @escaping () -> Void) -> Void {
        DXNetWorkTool.sharedInstance.post(buytool, body: ["id": type.rawValue as AnyObject, "count" : count as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            
            
            finishedBlock();
            
        }) { (error:SMError) in
            finishedBlock();
        }

    }
    
}
