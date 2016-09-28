//
//  LoginViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/24.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var pswTextFiled: UITextField!
    @IBOutlet weak var userNameTextfiled: UITextField!
    var nav = DXNavgationBar.getNav("登录")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userNameTextfiled.text = "18513581292"
        self.pswTextFiled.text = "123456"
        self.view .addSubview(self.nav)
        self.nav.addBackBtn(self, backSelector: #selector(LoginViewController.backaction(_:)))
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var forgetBtnClick: UIButton!
    @IBAction func loginbtnClick(_ sender: AnyObject) {
        UserManager.shareInstance.login(userNameTextfiled.text!, psw:pswTextFiled.text!) {
            (isOK, userInfo) in
            if isOK {
            
                self.navigationController?.popViewController(animated: true)
            } else {
            
                DXHelper.shareInstance.makeAlert("我草,登录失败了，这不科学", dur: 1, isShake: false)
            }
        }
        
    }
    @IBAction func backaction(_ sender: AnyObject) {
        
        self.navigationController?.popViewController(animated: true)
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
