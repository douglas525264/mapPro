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
    func getOrderId(_ type : Int,amount : Float,finishedBlock : @escaping (_ isOK : Bool , _ orderid : String?) -> () ) -> () {
        
        DXNetWorkTool.sharedInstance.get(getOrderID, body: ["type" : type as AnyObject,"amount" : amount as AnyObject], header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info : Dictionary<String, AnyObject>?, isOK : Bool, code : Int) in
            if isOK {
                let orderID = info?["msg"]
                finishedBlock(true,orderID as? String)
            } else {
                finishedBlock(false, nil)
            }
        }) { (error : SMError) in
                finishedBlock(false, nil)
        }

    }
    func pay(sub subject: String,OrderId orderId : String,body bb:String, Way way: CEPayType , amount money : Float ,CallBack callback : @escaping (_ status : CEPaymentStatus) -> ()) -> () {
        
        let fManager = FuqianlaPay.sharedPayManager()
        
        WXApi.registerApp("wx03565949c4ef222b", withDescription: "seeMoney")
        
        fManager?.pay(for: subject, order: orderId, body: bb, way: way, amount: CGFloat(money), callBack: { (ss: CEPaymentStatus) in
            
        })
      /*  fManager?.showPayStatusView = false
        fManager?.transactionParams = ["app_id":"UOIcpKx4jipj1WM3Wn2Tjw",
                                        "order_no": orderId ,
                                        "pmtTp":NSNumber(value: way.rawValue),
                                        "amount":"0.01",
                                        "subject":subject,
                                        "body":bb,
                                        "notify_url":notURL == nil ? ("https://api.drqmobile.com/v1/pay/fql/notify_url?uid=" + UserManager.shareInstance.getMe().userID!) : notURL!]
        fManager?.payStatusCallBack = { (_ status : CEPaymentStatus,_ result : String?) -> () in
        
            callback(status)
            
        }
        fManager?.myStart()*/
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
