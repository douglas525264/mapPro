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
    
    func getToolList(_ finishedBlock : (_ result : Array<ToolModel>?) -> Void) -> Void {
        DXNetWorkTool.sharedInstance.get(toolList, body: nil, header:  DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            
            
            
            
        }) { (error:SMError) in
            
        }
    }
    func buyTool(_ type:ToolType, _ count : Int ,finishedBlock : () -> Void) -> Void {
        DXNetWorkTool.sharedInstance.post(buytool, body: nil, header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info:Dictionary<String, AnyObject>?, isOK:Bool, code:Int) in
            
            
            finishedBlock();
            
        }) { (error:SMError) in
            finishedBlock();
        }

    }
    
}
