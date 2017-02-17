//
//  PayManager.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/19.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class PayManager: NSObject {
    typealias payCompletedBlock = (_ payStatus : CEPaymentStatus,_ paytype : Int) -> ()
    static let shareInstance = PayManager()
    var notURL : String?
    func getOrderId(_ type : Int,amount : Float,finishedBlock : @escaping (_ isOK : Bool , _ orderid : String?) -> ()  ) -> () {
        
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
    func pay(sub subject: String,OrderId orderId : String,body bb:String, Way way: CEPayType , amount money : Float ,CallBack callback : payCompletedBlock?) {
        
        let fManager = FuqianlaPay.sharedPayManager()
        
        WXApi.registerApp("wx03565949c4ef222b", withDescription: "seeMoney")
        
        fManager?.showPayStatusView = false
        
        let pp = ["app_id":"UOIcpKx4jipj1WM3Wn2Tjw",
                                        "order_no": orderId ,
                                        "pmtTp":NSNumber(value: way.rawValue),
                                        "amount":String(format: "%.2f", money),
                                        "subject":subject,
                                        "body":bb,
                                        "notify_url":notURL == nil ? "https://api.drqmobile.com/v1/pay/fql/callback" : notURL!] as [String : Any]
        fManager?.transactionParams = pp
        fManager?.payStatusCallBack = { (_ status : CEPaymentStatus,_ result : String?) -> () in
        
            callback?(status,way == .ptWeixinPay ? 2 : 3)
            
        }
        fManager?.myStart()
    }
    func getMyNotURL() -> String {
        DXNetWorkTool.sharedInstance.get(getNotURL, body: nil, header: DxDeveiceCommon.getDeviceCommonHeader(), completed: { (info : Dictionary<String, AnyObject>?, isOK : Bool, code : Int) in
            if isOK {
                self.notURL = info?["msg"] as! String?;
                //存储 notURL
            }
        }) { (error : SMError) in
            
        }
        return "LLLL"
    }
}
