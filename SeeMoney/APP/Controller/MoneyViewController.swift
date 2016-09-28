//
//  MoneyViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController {

    @IBOutlet weak var goldCountLable: UILabel!
    @IBOutlet weak var accountNumLable: UILabel!
    var nav = DXNavgationBar.getNav("钱包")
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.greenColor()
        let me = UserManager.shareInstance.getMe()
        accountNumLable.text = String(format: "账户余额: %.2f元", me.accountNum)
        goldCountLable.text = String(format: "金币个数: %.2f个", me.goldCount)
        self.view .addSubview(self.nav)
        self.nav.addBackBtn(self, backSelector: #selector(MoneyViewController.backClick(_:)))
        // Do any additional setup after loading the view.
    }
    func backClick(_ sender:UIButton?) {
     self.navigationController?.popViewController(animated: true)
    }
    @IBAction func addAcountClick(_ sender: AnyObject) {
        
    }

    @IBAction func tixianClick(_ sender: AnyObject) {
    }
    deinit {
    
        print("MoneyViewController has deinit")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
