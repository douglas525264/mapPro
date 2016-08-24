//
//  RegisterViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/24.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var usernameTextfiled: UITextField!

    @IBOutlet weak var pswTextFiled: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func registerBtnClick(sender: AnyObject) {
        
        if usernameTextfiled.text == nil || pswTextFiled.text  == nil {
            DXHelper.shareInstance.makeAlert("请输入参数", dur: 1, isShake: false)
        }
        
        UserManager.shareInstance.register(usernameTextfiled.text!, psw:pswTextFiled.text!) { (isOK, userInfo) in
            if isOK {
                
                self.navigationController?.popViewControllerAnimated(true)
            } else {
                
                DXHelper.shareInstance.makeAlert("我草,注册失败了，这不科学", dur: 1, isShake: false)
            }
        }

    }


    @IBAction func backAction(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
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
