//
//  PayManager.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/19.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class PayManager: NSObject {
    static let shareInstance = PayManager()
    var notURL : String?
    func getOrderId(_ type : Int,amount : Float) -> String {
        
        DXNetWorkTool.sharedInstance.get(getOrderID, body: ["type" : type as AnyObject,"amount" : amount as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info : Dictionary<String, AnyObject>?, isOK : Bool, code : Int) in
            
        }) { (error : SMError) in
            
        }
        return "12356253"
    }
    func pay(sub subject: String,OrderId orderId : String,body bb:String, Way way: CEPayType , amount money : Float ,CallBack callback : @escaping (_ status : CEPaymentStatus) -> ()) -> () {
        
        let fManager = FuqianlaPay.sharedPayManager()
        
        WXApi.registerApp("wx03565949c4ef222b", withDescription: "seeMoney")
        fManager?.transactionParams = ["app_id":"UOIcpKx4jipj1WM3Wn2Tjw",
                                        "order_no": orderId ,
                                        "pmtTp":way,
                                        "amount":"0.01",
                                        "subject":subject,
                                        "body":bb,
                                        "notify_url":notURL == nil ? "http://10.100.140.124:8081/adapter-client/receive/notify.htm" : notURL!]
        fManager?.payStatusCallBack = { (_ status : CEPaymentStatus,_ result : String?) -> () in
        
            callback(status)
            
        }
        fManager?.startAction()
        
    }
    func getMyNotURL() -> String {
        DXNetWorkTool.sharedInstance.get(getNotURL, body: nil, header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info : Dictionary<String, AnyObject>?, isOK : Bool, code : Int) in
            if isOK {
            
                //存储 notURL
            }
        }) { (error : SMError) in
            
        }
        return "LLLL"
    }
}
