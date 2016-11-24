//
//  SlideViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
public protocol SlideViewControllerDelegate : NSObjectProtocol {
    

    func founctionCallBackAtIndex(_ index:NSInteger)
 
}

class SlideViewController: DXSlideViewController,UITableViewDelegate,UITableViewDataSource,UserManagerDlegate {
    weak var delegate: SlideViewControllerDelegate?
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        
        return table
    }()
    var headerView = UIView()
    var headerImageView = UIImageView()
    var loginBtn = UIButton(type: UIButtonType.custom)
    var me = UserManager.shareInstance.getMe()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shareInstance.delegate = self;
        self.refreashUI()
       self.createLocalUI()
       
        // Do any additional setup after loading the view.
    }
    func createLocalUI() {
        
        self.tableView.frame = self.slideView.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView .register(UITableViewCell().classForCoder, forCellReuseIdentifier:"SettingTableTable")
        self.slideView .addSubview(self.tableView)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.slideView.frame.size.width, height: 160)
        self.tableView.tableHeaderView = headerView
        headerImageView.frame = CGRect(x: headerView.frame.size.width/2 - 30, y: (headerView.frame.size.height - 20)/2 - 30 + 20, width: 60, height: 60)
        headerImageView.image = UIImage(named: "zapya_sidebar_head_superman")
        headerView .addSubview(headerImageView)
        let bottomLine = UILabel(frame: CGRect(x: 20, y: self.headerView.frame.size.height - 5, width: headerView.frame.size.width - 40, height: 0.5))
        bottomLine.alpha = 0.6
        bottomLine.backgroundColor = UIColor.lightGray
        headerView .addSubview(bottomLine)
        
        loginBtn.frame = CGRect(x: 0, y: headerImageView.frame.origin.y + headerImageView.frame.size.height, width: headerView.frame.size.width, height: 40)
        loginBtn.titleLabel?.textColor = UIColor.lightGray
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        let me = UserManager.shareInstance.getMe()
        switch me.loginStatus {
        case UserLoginStatus.bagStatusHaslogin:
            loginBtn.setTitle(me.username, for: UIControlState())
            break
        default:
            loginBtn.setTitle("未登录", for: UIControlState())
            break
        }
        
        loginBtn.setTitleColor(UIColor.lightGray, for: UIControlState())
        loginBtn.backgroundColor = UIColor.clear
        headerView.addSubview(loginBtn)
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(SlideViewController.loginBtnClick))
        headerView .addGestureRecognizer(oneTap)
        
    }
    
    func loginBtnClick() {
        
        if (self.delegate != nil) {
            self.delegate?.founctionCallBackAtIndex(5)
        }

    }
    //MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.delegate != nil) {
            self.delegate?.founctionCallBackAtIndex((indexPath as NSIndexPath).row)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (me.loginStatus == UserLoginStatus.bagStatusHaslogin) ? 5:3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableTable")
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell?.textLabel?.text = "给捡钱点赞";
            cell?.imageView?.image = UIImage(named: "zapya_ios_profile_evaluate")
            break
        case 1:
            let str = String(format: "钱包(%.2f元)",me.accountNum)
            cell?.textLabel?.text = str
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        case 2:
            cell?.textLabel?.text = "设置"
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        case 3:
            cell?.textLabel?.text = "道具"
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        case 4:
            cell?.textLabel?.text = "退出登录"
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        default:break
            
        }
        cell?.textLabel?.textColor = UIColor.lightGray
        return cell!
    }
    func userStatusChange(_ user:UserModel) {
        
        self.refreashUI()
    }
    func refreashUI() {
        me = UserManager.shareInstance.getMe()
        switch me.loginStatus {
        case UserLoginStatus.bagStatusHaslogin:
            loginBtn.setTitle(me.username, for: UIControlState())
            break
        default:
            loginBtn.setTitle("未登录", for: UIControlState())
            break
        }
        self.tableView.reloadData()
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
