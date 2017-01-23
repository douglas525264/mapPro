//
//  ChongZhiViewController.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/23.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class ChongZhiViewController: UIViewController {

    @IBOutlet weak var cTextfiled: UITextField!
    var nav = DXNavgationBar.getNav("充值")
    @IBOutlet weak var yueLable: UILabel!
    let me = UserManager.shareInstance.getMe()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view .addSubview(self.nav)
         self.nav.addBackBtn(self, backSelector: #selector(ChongZhiViewController.backClick(_:)))
         self.view.backgroundColor = bgColor
         self.yueLable.text = String(format: "当前余额:%.2f", me.accountNum)
        // Do any additional setup after loading the view.
    }
    
    func backClick(_ sender:UIButton?) {
        
        if self.navigationController?.popViewController(animated: true) != nil {
            
        }
    }

    @IBOutlet weak var cBtn: UIButton!

    @IBAction func cBtnClick(_ sender: Any) {
        let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
        let payVC = mainStory.instantiateViewController(withIdentifier: "PayMoneyViewController") as! PayMoneyViewController
        payVC.name = "发红包"
        let pric = Double((self.cTextfiled.text!))!
        payVC.price = Float(pric)
        payVC.paytype = .payTypeChongzhi
        payVC.payCallBack = { (_ payStatus : CEPaymentStatus) -> () in
            
            switch payStatus {
            case .payResultSuccess:
                DXHelper.shareInstance.makeAlert("充值成功", dur: 1, isShake: false)
                self.me.accountNum += pric;
                UserManager.shareInstance.saveModel(self.me)
                self.yueLable.text = String(format: "当前余额:%.2f", self.me.accountNum)
                UserManager.shareInstance.updateInfo()
                break;
            default:
                break;
            }
            
        }
        self.navigationController?.pushViewController(payVC, animated: true)

        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
