//
//  DXNetWorkTool.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import AFNetworking
typealias completedBlock = (Dictionary<String,AnyObject>,Bool,Int) -> () //或者 () -> Void
typealias failBlock = (NSError)->();
//返回值是String
typealias funcBlockA = (Int,Int) -> String
//返回值是一个函数指针，入参为String
typealias funcBlockB = (Int,Int) -> (String)->()
//返回值是一个函数指针，入参为String 返回值也是String
typealias funcBlockC = (Int,Int) -> (String)->String
//网络请求控制类
class DXNetWorkTool: NSObject {
    
    static let sharedInstance = DXNetWorkTool()
    private override init() {}
    func justATest() {
        
        print("TTTTTT")
    }
    //POST
    func post(url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:completedBlock,fail:failBlock) {
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 10
        manager.responseSerializer = AFHTTPResponseSerializer()
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.responseSerializer.setValue(value, forKey: key);
                
            }
        }
        manager.POST(url, parameters: body, progress: nil, success: { (operation, response) in
             print(response)
            
             completed(response as! Dictionary,true,200)
            
            }, failure:  { (operation, response) in
                fail(response)
        })
    }
    func get(url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:completedBlock,fail:failBlock) {
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 10
        manager.responseSerializer = AFHTTPResponseSerializer()
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.responseSerializer.setValue(value, forKey: key);
            }
        }
        manager.GET(url, parameters: body, progress: nil, success: { (operation, response) in
            print(response)
            completed(response as! Dictionary,true,200)
            }, failure:  { (operation, response) in
            fail(response)
        })
    }

    
}
