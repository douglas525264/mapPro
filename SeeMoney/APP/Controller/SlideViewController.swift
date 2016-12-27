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
enum SettingCommend:Int {
    case SettingCommendMyTools = 1
    case SettingCommendMyMoney = 2
    case SettingCommendLikeBaoBao
    case SettingCommendFeedBack
    case SettingCommendGuid
    case SettingCommendSetting
    case SettingCommendAbout
    case SettingCommendChangeAvatar
    case SettingCommendLogin
    case SettingCommendChangeNick
}
class SlideViewController: DXNewSlideViewController,UITableViewDelegate,UITableViewDataSource,UserManagerDlegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
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
        let oneTap = UITapGestureRecognizer()
        oneTap.numberOfTapsRequired = 1
        oneTap.addTarget(self, action: #selector(SlideViewController.avatarTap(_:)))
        headerImageView.addGestureRecognizer(oneTap)
        headerImageView.isUserInteractionEnabled = true
        headerImageView.layer.cornerRadius = 30
        headerImageView.layer.masksToBounds = true
        headerView .addSubview(headerImageView)
        
        
        loginBtn.frame = CGRect(x: 0, y: headerImageView.frame.origin.y + headerImageView.frame.size.height, width: headerView.frame.size.width, height: 40)
        loginBtn.titleLabel?.textColor = UIColor.lightGray
        loginBtn.addTarget(self, action: #selector(SlideViewController.loginBtnClick), for: .touchUpInside)
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

        let myToolBtn = SlideBtn(type: .custom)
        var width = self.slideView.frame.size.width/2 - 40
        width = width > 160 ? 160 : width
        myToolBtn.frame = CGRect(x: self.slideView.frame.size.width/2 - width - 20, y: headerView.frame.size.height - 20 - 40, width: width, height: 35)
        myToolBtn.tag = 0;
        myToolBtn.setTitle("我的道具", for: .normal)
        myToolBtn.addTarget(self, action: #selector(SlideViewController.normalBtnClick(_:)), for: .touchUpInside)
        myToolBtn.setTitleColor(UIColor.white, for: .normal)
        myToolBtn.layer.borderWidth = 0.5
        myToolBtn.layer.borderColor = UIColor.white.cgColor
        myToolBtn.layer.cornerRadius = 5
        myToolBtn.setImage(UIImage(named : "icon-qianbao"), for: .normal)
        myToolBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        headerView .addSubview(myToolBtn)
        
        let myMoneyBtn = SlideBtn(type: .custom)
        myMoneyBtn.addTarget(self, action: #selector(SlideViewController.normalBtnClick(_:)), for: .touchUpInside)
        myMoneyBtn.frame = CGRect(x: self.slideView.frame.size.width/2 + 20, y: headerView.frame.size.height - 20 - 40, width: width, height: 35)
        myMoneyBtn.setTitle("我的钱包", for: .normal)
        myMoneyBtn.setTitleColor(UIColor.white, for: .normal)
        myMoneyBtn.layer.borderWidth = 0.5
        myMoneyBtn.layer.borderColor = UIColor.white.cgColor
        myMoneyBtn.layer.cornerRadius = 5
        myMoneyBtn.setImage(UIImage(named : "icon-qianbao"), for: .normal)
        myMoneyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        myMoneyBtn.tag = 1;
        headerView .addSubview(myMoneyBtn)
        

        
        let closeBtn = UIButton(type:.custom)
        closeBtn.frame = CGRect(x: 15, y: 25, width: 30, height: 30);
        closeBtn .setImage(UIImage(named : "cha"), for: UIControlState.normal)
       
        closeBtn.addTarget(self, action: #selector(SlideViewController.dismiss1), for: UIControlEvents.touchUpInside)
        self.view .addSubview(closeBtn)
        
        self.slideView.backgroundColor = bgColor
        
        headerView.sendSubview(toBack: bgImageView)
    }
    
     func dismiss1() {
        super.dismiss()
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
    }
    func avatarTap(_ sender : UIGestureRecognizer) -> Void {
        if UserManager.shareInstance.getMe().loginStatus == UserLoginStatus.bagStatusUnLogin {
        
            getCommend(.SettingCommendLogin)
        } else {
            getCommend(.SettingCommendChangeAvatar)
        }
    }
    func loginBtnClick() {
        if UserManager.shareInstance.getMe().loginStatus == UserLoginStatus.bagStatusUnLogin {
            
            getCommend(.SettingCommendLogin)
        } else {
            getCommend(.SettingCommendChangeNick)
        }

    }
    func normalBtnClick(_ sender : UIButton) {
        getCommend(sender.tag == 0 ? .SettingCommendMyTools : .SettingCommendMyMoney)
    }
    
    //MARK - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            if indexPath.row == 0{
               getCommend(.SettingCommendLikeBaoBao)
            }
            if indexPath.row == 1 {
               getCommend(.SettingCommendFeedBack)
                
            }
            break
        case 1:
            if indexPath.row == 0{
               getCommend(.SettingCommendGuid)
            }
            if indexPath.row == 1 {
                getCommend(.SettingCommendSetting)
                
            }
            break
        case 2:
            if indexPath.row == 0{
                getCommend(.SettingCommendAbout)
            }
            if indexPath.row == 1 {
                
                
            }
            break

        default: break
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
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell?.accessoryType = .disclosureIndicator
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
    func getCommend(_ commend : SettingCommend) {
        switch commend {
        case .SettingCommendLikeBaoBao:
            
            break
        case .SettingCommendMyTools:
            MainMapViewController.shareInstance?.push(toVC: MyToolViewController(), animated: true)
            break
        case .SettingCommendMyMoney:
            print("钱包")
            let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
            let lgVC = mainStory.instantiateViewController(withIdentifier: "MoneyViewController")
            MainMapViewController.shareInstance?.push(toVC: lgVC, animated: true)
            
            break
        case .SettingCommendFeedBack:
            
            break
        case .SettingCommendGuid:
            MainMapViewController.shareInstance?.push(toVC: AboutViewController(), animated: true)
            break
        case .SettingCommendSetting:
            let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
            let setVC = mainStory.instantiateViewController(withIdentifier: "SettingViewController")
            
            MainMapViewController.shareInstance?.push(toVC: setVC, animated: true)
            break
        case .SettingCommendAbout:
            MainMapViewController.shareInstance?.push(toVC: ToolListViewController(), animated: true)
            break
        case .SettingCommendChangeAvatar:
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.loadSource(type: .photoLibrary)
            } else {
                print("相册不可用")
            }
            break
        case .SettingCommendLogin:
            let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
            let lgVC = mainStory.instantiateViewController(withIdentifier: "LoginViewController")
            MainMapViewController.shareInstance?.navigationController?.pushViewController(lgVC, animated: true)
            break
        case .SettingCommendChangeNick:
            //修改昵称
            let alertVc = UIAlertController(title: "修改昵称"  , message: "在下面框中输入昵称", preferredStyle: UIAlertControllerStyle.alert);
            alertVc.addTextField(configurationHandler: { (te:UITextField) in
                te.placeholder = "请输入昵称"
            })
            let alertOKAc = UIAlertAction(title: "修改", style:UIAlertActionStyle.default , handler: { (ac : UIAlertAction) in
                let me = UserManager.shareInstance.getMe()
                let nameTextFile = alertVc.textFields?.first
                
                if let newName = nameTextFile?.text {
                    
                    me.username = newName;
                    //UserManager.shareInstance.asyToSever(["nick":me.username as AnyObject ,"gender":1 as AnyObject] fi)
                    UserManager.shareInstance.asyToSever(["nick":me.username as AnyObject ,"gender":1 as AnyObject], finishedBlock: { (isOK : Bool) in
                        if isOK {
                            
                            UserManager.shareInstance.saveModel(me);
                        } else {
                            print("上传失败")
                        }
                    })
                }
                
            })
            let alertcancel = UIAlertAction(title: "取消", style:UIAlertActionStyle.default , handler: { (ac : UIAlertAction) in
                
            })
            alertVc.addAction(alertOKAc);
            alertVc.addAction(alertcancel);
            
            
            MainMapViewController.shareInstance?.present(alertVc, animated: true, completion: {
                
            });

            break
            
        }
    }
    
    func loadSource(type : UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = type
        picker.delegate = self
        picker.allowsEditing = true;
        MainMapViewController.shareInstance?.present(picker, animated: true, completion: { 
            
        })
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image  = info[UIImagePickerControllerEditedImage] as? UIImage;
        if (image != nil)  {
            //上传图片 等待回调刷新UI
            self.headerImageView.image = image
        }
        picker.dismiss(animated: true, completion: nil)
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
