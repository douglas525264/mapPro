//
//  MoneyViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class MoneyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var goldCountLable: UILabel!
    @IBOutlet weak var accountNumLable: UILabel!
    
    var nav = DXNavgationBar.getNav("钱包")
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var payBtn: UIButton!
    
    @IBOutlet weak var tixianBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor.greenColor()
               self.view .addSubview(self.nav)
        self.nav.addBackBtn(self, backSelector: #selector(MoneyViewController.backClick(_:)))
        self .createUI()
        // Do any additional setup after loading the view.
    }
    func createUI() {
        self.view.backgroundColor = bgColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView .register(UITableViewCell().classForCoder, forCellReuseIdentifier:"MoneyTableCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.backgroundColor = UIColor.clear
        self.payBtn.layer.cornerRadius = 5
        self.tixianBtn.layer.cornerRadius = 5

    }
    func backClick(_ sender:UIButton?) {
        if self.navigationController?.popViewController(animated: true) != nil {
        
        }
    }
    //MARK - TableView
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 { return 2}
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoneyTableCell")
        
        let me = UserManager.shareInstance.getMe()
       
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                cell?.textLabel?.text = String(format: "账户余额: %.2f元", me.accountNum/100.0)
                
            } else {
                cell?.textLabel?.text = String(format: "金币个数: %.2f个", me.goldCount)
                
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

    @IBAction func addAcountClick(_ sender: AnyObject) {
        
    }

    @IBAction func paybtnClick(_ sender: Any) {
        
        let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
        let lgVC = mainStory.instantiateViewController(withIdentifier: "ChongZhiViewController")
        self.navigationController?.pushViewController(lgVC, animated: true)

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
