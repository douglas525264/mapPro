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

class SlideViewController: DXNewSlideViewController,UITableViewDelegate,UITableViewDataSource,UserManagerDlegate {
    weak var delegate: SlideViewControllerDelegate?
    lazy var tableView:UITableView = {
        let table = UITableView(frame: CGRect.zero, style: UITableViewStyle.grouped)
        
        return table
    }()
     var  bgImageView = UIImageView()
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
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.backgroundColor = UIColor.clear
        
        headerView.frame = CGRect(x: 0, y: 0, width: self.slideView.frame.size.width, height: 260)
        headerView.backgroundColor = UIColor.red
        
        
        self.tableView.tableHeaderView = headerView
        
        bgImageView.frame =  CGRect(x: 0, y: self.headerView.frame.size.height - 260, width: self.slideView.frame.size.width, height: 260)
        bgImageView.image = UIImage(named: "personBG")
        bgImageView.contentMode = UIViewContentMode.scaleAspectFill
        bgImageView.layer.masksToBounds = true;
        headerView .addSubview(bgImageView);
        
        self.tableView.tableHeaderView = headerView;
        
        
        headerImageView.frame = CGRect(x: headerView.frame.size.width/2 - 30, y: (headerView.frame.size.height - 20)/2 - 30 + 20 - 30, width: 60, height: 60)
        headerImageView.image = UIImage(named: "zapya_sidebar_head_superman")
        
        headerView .addSubview(headerImageView)
        
        
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
       // let oneTap = UITapGestureRecognizer(target: self, action: #selector(SlideViewController.loginBtnClick))
       // headerView .addGestureRecognizer(oneTap)
        let myToolBtn = SlideBtn(type: .custom)
        var width = self.slideView.frame.size.width/2 - 40
        width = width > 160 ? 160 : width
        myToolBtn.frame = CGRect(x: self.slideView.frame.size.width/2 - width - 20, y: headerView.frame.size.height - 20 - 40, width: width, height: 35)
        myToolBtn.setTitle("我的道具", for: .normal)
        myToolBtn.setTitleColor(UIColor.white, for: .normal)
        myToolBtn.layer.borderWidth = 0.5
        myToolBtn.layer.borderColor = UIColor.white.cgColor
        myToolBtn.layer.cornerRadius = 5
        myToolBtn.setImage(UIImage(named : "icon-qianbao"), for: .normal)
        myToolBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        headerView .addSubview(myToolBtn)
        
        let myMoneyBtn = SlideBtn(type: .custom)
        myMoneyBtn.frame = CGRect(x: self.slideView.frame.size.width/2 + 20, y: headerView.frame.size.height - 20 - 40, width: width, height: 35)
        myMoneyBtn.setTitle("我的钱包", for: .normal)
        myMoneyBtn.setTitleColor(UIColor.white, for: .normal)
        myMoneyBtn.layer.borderWidth = 0.5
        myMoneyBtn.layer.borderColor = UIColor.white.cgColor
        myMoneyBtn.layer.cornerRadius = 5
        myMoneyBtn.setImage(UIImage(named : "icon-qianbao"), for: .normal)
        myMoneyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        headerView .addSubview(myMoneyBtn)

        
        let closeBtn = UIButton(type:.custom)
        closeBtn.frame = CGRect(x: 15, y: 25, width: 30, height: 30);
        closeBtn .setImage(UIImage(named : "cha"), for: UIControlState.normal)
       
        closeBtn.addTarget(self, action: #selector(SlideViewController.dismiss1), for: UIControlEvents.touchUpInside)
        self.view .addSubview(closeBtn)
        
        self.slideView.backgroundColor = RGB(246, g: 246, b: 246, a: 1)
        
        headerView.sendSubview(toBack: bgImageView)
    }
     func dismiss1() {
        super.dismiss()
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
        if UserManager.shareInstance.isLogin() {
        return 3
        }
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {return 1}
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingTableTable")
        
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "给探包宝点赞";
                cell?.imageView?.image = UIImage(named: "icon_zhinan")
            } else {
                cell?.textLabel?.text = "用户反馈";
                cell?.imageView?.image = UIImage(named: "icon_zhinan")
            }
            
            break
        case 1:
            if indexPath.row == 0 {
                cell?.textLabel?.text = "用户指南";
                cell?.imageView?.image = UIImage(named: "icon_zhinan")
            } else {
                cell?.textLabel?.text = "设置";
                cell?.imageView?.image = UIImage(named: "icon_shezhi")
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
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y;
        if offset < 0 {
            let h = headerView.frame.size.height - offset;
            bgImageView.frame = CGRect(x: 0, y: self.headerView.frame.size.height - h, width: bgImageView.frame.size.width, height: h)
        
        } else {
            bgImageView.frame = CGRect(x: 0, y: self.headerView.frame.size.height - 260, width: self.slideView.frame.size.width, height: 260)
        }
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
