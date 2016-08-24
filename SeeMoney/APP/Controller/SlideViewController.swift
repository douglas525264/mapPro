//
//  SlideViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
public protocol SlideViewControllerDelegate : NSObjectProtocol {
    
    // Center latitude and longitude of the annotation view.
    // The implementation of this property must be KVO compliant.
    func founctionCallBackAtIndex(index:NSInteger)
    // Title and subtitle for use by selection UI.
}

class SlideViewController: DXSlideViewController,UITableViewDelegate,UITableViewDataSource,UserManagerDlegate {
    weak var delegate: SlideViewControllerDelegate?
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        
        return table
    }()
    var headerView = UIView()
    var headerImageView = UIImageView()
    var loginBtn = UIButton(type: UIButtonType.Custom)
    var me = UserManager.shareInstance.getMe()
    
    //var <#name#> = <#value#>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserManager.shareInstance.delegate = self;
       self.createLocalUI()
        // Do any additional setup after loading the view.
    }
    func createLocalUI() {
        
        self.tableView.frame = self.slideView.bounds
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView .registerClass(UITableViewCell().classForCoder, forCellReuseIdentifier:"SettingTableTable")
        self.slideView .addSubview(self.tableView)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        
        
        headerView.frame = CGRectMake(0, 0, self.slideView.frame.size.width, 160)
        self.tableView.tableHeaderView = headerView
        headerImageView.frame = CGRectMake(headerView.frame.size.width/2 - 30, (headerView.frame.size.height - 20)/2 - 30 + 20, 60, 60)
        headerImageView.image = UIImage(named: "zapya_sidebar_head_superman")
        headerView .addSubview(headerImageView)
        let bottomLine = UILabel(frame: CGRectMake(20, self.headerView.frame.size.height - 5, headerView.frame.size.width - 40, 0.5))
        bottomLine.alpha = 0.6
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        headerView .addSubview(bottomLine)
        
        loginBtn.frame = CGRectMake(0, headerImageView.frame.origin.y + headerImageView.frame.size.height, headerView.frame.size.width, 40)
        loginBtn.titleLabel?.textColor = UIColor.lightGrayColor()
        loginBtn.titleLabel?.font = UIFont.systemFontOfSize(12)
        let me = UserManager.shareInstance.getMe()
        switch me.loginStatus {
        case UserLoginStatus.bagStatusHaslogin:
            loginBtn.setTitle(me.username, forState: UIControlState.Normal)
            break
        default:
            loginBtn.setTitle("未登录", forState: UIControlState.Normal)
            break
        }
        
        loginBtn.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Normal)
        loginBtn.backgroundColor = UIColor.clearColor()
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (self.delegate != nil) {
            self.delegate?.founctionCallBackAtIndex(indexPath.row)
        }
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (me.loginStatus == UserLoginStatus.bagStatusHaslogin) ? 4:3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("SettingTableTable")
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "给捡钱点赞";
            cell?.imageView?.image = UIImage(named: "zapya_ios_profile_evaluate")
            break
        case 1:
            let str = String(format: "钱包(%ld元)",me.accountNum)
            cell?.textLabel?.text = str
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        case 2:
            cell?.textLabel?.text = "设置"
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        case 3:
            cell?.textLabel?.text = "退出登录"
            cell?.imageView?.image = UIImage(named: "zapya_slidemenu_icon_setting")
            break
        default:break
            
        }
        cell?.textLabel?.textColor = UIColor.lightGrayColor()
        return cell!
    }
    func userStatusChange(user:UserModel) {
        
        self.refreashUI()
    }
    func refreashUI() {
        me = UserManager.shareInstance.getMe()
        switch me.loginStatus {
        case UserLoginStatus.bagStatusHaslogin:
            loginBtn.setTitle(me.username, forState: UIControlState.Normal)
            break
        default:
            loginBtn.setTitle("未登录", forState: UIControlState.Normal)
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
