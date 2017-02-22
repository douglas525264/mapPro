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
    fileprivate override init() {}
    func justATest() {
        
        print("TTTTTT")
    }
    //POST
    func post(_ url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:@escaping completedBlock,fail:@escaping failBlock) {
        print("header : \(header)")
        print("body : \(body)")
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 3
        manager.responseSerializer = AFHTTPResponseSerializer()
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
                
            }
        }
        manager.post(url, parameters: body, progress: nil, success: { (operation, response) in
             print("class + \((response as AnyObject).classForCoder)")
            let str = String(data: response as! Data, encoding: String.Encoding.utf8)
            let info = try? JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
            print("Post get str : \(str)")
            if info != nil {
                let dicInfo = info as? Dictionary<String,AnyObject>
                let code = dicInfo!["code"] as! NSInteger
                
                if code == 200 {
                    let json = dicInfo!["json"]
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
    func get(_ url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:@escaping completedBlock,fail:@escaping failBlock) {
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 10
        manager.responseSerializer = AFHTTPResponseSerializer()
        
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
            }
        }
        manager.get(url, parameters: body, progress: nil, success: { (operation, response) in
            print("class + \((response as AnyObject).classForCoder)")
            let str = String(data: response as! Data, encoding: String.Encoding.utf8)
            let info = try? JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
            print("GET get str : \(str)")
            if info != nil {
                let infoDic = info as? Dictionary<String,AnyObject>
                
                let code = infoDic!["code"] as! NSInteger
                
                if code == 200 {
                    if let msg = infoDic?["msg"] {
                        var inn = infoDic!["json"] as? Dictionary<String,AnyObject>
                        if inn != nil {
                            inn?["msg"] = msg
                        } else {
                            inn = ["msg" : msg]
                        }
                        completed(inn,true,200)
                    
                    } else {
                        completed((infoDic!["json"] as? Dictionary<String,AnyObject>)!,true,200)
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
    func put(_ url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:@escaping completedBlock,fail:@escaping failBlock) -> Void {
        print("header : \(header)")
        print("body : \(body)")
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 3
        manager.responseSerializer = AFHTTPResponseSerializer()
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
                
            }
        }
        manager.put(url, parameters: body, success: { (operation, response) -> Void in
            print("class + \((response as AnyObject).classForCoder)")
            
            let str = String(data: response as! Data, encoding: String.Encoding.utf8)
            
            let info = try? JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print("GET get str : \(str)")
            if info != nil {
                let infoDic = info as? Dictionary<String,AnyObject>
                
                let code = infoDic!["code"] as! NSInteger
                
                if code == 200 {
                    completed((infoDic!["json"] as? Dictionary<String,AnyObject>)!,true,200)
                } else {
                    let err = SMError()
                    err.code = code
                    fail(err)
                }
                
                
            } else {
                fail(SMError())
                // fail(NSError(domain: "", code: 400, userInfo: nil))
            }

        
        }, failure: { (operation,error) -> Void in
        
            fail(SMError())
        })
    }
    func upload(_ data : Data ,url:String,body:Dictionary<String,AnyObject>?,header:Dictionary<String,AnyObject>?,completed:@escaping completedBlock,fail:@escaping failBlock) -> Void {
        print("header : \(header)")
        print("body : \(body)")
        print("URL : \(url)")
        let manager = AFHTTPSessionManager();
        
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.timeoutInterval = 3
        manager.responseSerializer = AFHTTPResponseSerializer()
        if let header1 = header  {
            for (key,value)  in header1 {
                manager.requestSerializer.setValue(value as? String, forHTTPHeaderField: key);
                
            }
        }
        manager.post(url, parameters: body, constructingBodyWith: {(formatdata : AFMultipartFormData) -> Void in
            
            formatdata.appendPart(withFileData: data, name: "file", fileName: "avatar", mimeType: "png")
            
        }, progress: { (progress : Progress) -> Void in
            print("progress : %@",progress)
        
        },  success: { (operation, response) in
            
            print("class + \((response as AnyObject).classForCoder)")
            
            let str = String(data: response as! Data, encoding: String.Encoding.utf8)
            
            let info = try? JSONSerialization.jsonObject(with: response as! Data, options: JSONSerialization.ReadingOptions.allowFragments)
            
            print("GET get str : \(str)")
//            if info != nil {
//                let infoDic = info as? Dictionary<String,AnyObject>
//                
//                let code = infoDic!["code"] as! NSInteger
//                
//                if code == 200 {
//                    completed((infoDic!["json"] as? Dictionary<String,AnyObject>)!,true,200)
//                } else {
//                    let err = SMError()
//                    err.code = code
//                    fail(err)
//                }
//                
//                
//            } else {
//                fail(SMError())
//                // fail(NSError(domain: "", code: 400, userInfo: nil))
//            }
//
            
        }, failure:  { (operation, response) in
            
            fail(SMError())
            
        })
    }

    
}
