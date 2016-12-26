//
//  SettingViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var nav = DXNavgationBar.getNav("设置")
    
    @IBOutlet weak var logouBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self .createUI()
        // Do any additional setup after loading the view.
    }
    func createUI() {
        self.view.backgroundColor = UIColor.white
        self.view .addSubview(self.nav)
        
        self.nav.addBackBtn(self, backSelector: #selector(SettingViewController.backClick(_:)))
        self.view.backgroundColor = bgColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView .register(UITableViewCell().classForCoder, forCellReuseIdentifier:"SettingTableCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.backgroundColor = UIColor.clear
        self.logouBtn.layer.cornerRadius = 5
        self.logouBtn.isHidden = (UserManager.shareInstance.getMe().loginStatus == .bagStatusUnLogin)
    }

    @IBAction func logoutBtnClick(_ sender: Any) {
        let me = UserManager.shareInstance.getMe()
        me.loginStatus = UserLoginStatus.bagStatusUnLogin
        UserManager.shareInstance.saveModel(me)
        self.logouBtn.isHidden = true
    }
    func backClick(_ sender:UIButton?) {
        
        if self.navigationController?.popViewController(animated: true) != nil {
            
        }

    }
    //MARK - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 1}
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth!, height: 20))
        footer.backgroundColor = UIColor.clear
        return footer
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth!, height: 0.1))
        footer.backgroundColor = UIColor.clear
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableCell")
        
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "账号管理";
              
            } else {
                cell?.textLabel?.text = "";
               
            }
            
            break
        case 1:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "自动使用道具";
              
            } else {
                cell?.textLabel?.text = "消息通知";
               
            }
            
            break
        case 2:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "关于探包宝";
                cell?.imageView?.image = UIImage(named: "icon_zhinan")
            } else {
                cell?.textLabel?.text = "设置";
                cell?.imageView?.image = UIImage(named: "icon_zhinan")
            }
            
            break
            
        default:break
            
        }
        cell?.textLabel?.textColor = UIColor.black
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.accessoryType = .disclosureIndicator
        return cell!
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
