//
//  DXNetWorkTool.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import AFNetworking
typealias completedBlock = (Dictionary<String,AnyObject>?,Bool,Int) -> () //或者 () -> Void
typealias failBlock = (SMError)->();
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
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
                
            }
        }
        manager.POST(url, parameters: body, progress: nil, success: { (operation, response) in
             print("class + \(response?.classForCoder)")
            let str = String(data: response as! NSData, encoding: NSUTF8StringEncoding)
            let info = try? NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments)
            print("Post get str : \(str)")
            if info != nil {
                
                let code = info!["code"] as! NSInteger
                
                if code == 200 {
                    let json = info!["json"]
                  //  print(json!!.description)
                    if !(json is NSNull) {
                        completed((json as? Dictionary<String,AnyObject>)!,true,200)
                    } else {
                        completed(nil,true,200)
                    }
                   
                } else {
                    let err = SMError()
                    err.code = code
                    fail(err)
                }

            
            } else {
            fail(SMError())
           // fail(NSError(domain: "", code: 400, userInfo: nil))
            }
            }, failure:  { (operation, response) in
                fail(SMError())
        })
    }
    func get(url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:completedBlock,fail:failBlock) {
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 10
        manager.responseSerializer = AFHTTPResponseSerializer()
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
            }
        }
        manager.GET(url, parameters: body, progress: nil, success: { (operation, response) in
            print("class + \(response?.classForCoder)")
            let str = String(data: response as! NSData, encoding: NSUTF8StringEncoding)
            let info = try? NSJSONSerialization.JSONObjectWithData(response as! NSData, options: NSJSONReadingOptions.AllowFragments)
            print("GET get str : \(str)")
            if info != nil {
                
                let code = info!["code"] as! NSInteger
                
                if code == 200 {
                    completed((info!["json"] as? Dictionary<String,AnyObject>)!,true,200)
                } else {
                    let err = SMError()
                    err.code = code
                    fail(err)
                }
                
                
            } else {
                fail(SMError())
                // fail(NSError(domain: "", code: 400, userInfo: nil))
            }
            }, failure:  { (operation, response) in
                fail(SMError())

        })
    }

    
}
