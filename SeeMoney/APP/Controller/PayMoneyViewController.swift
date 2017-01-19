//
//  PayMoneyViewController.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/19.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class PayMoneyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var nameLable: UILabel!

    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var moneyLable: UILabel!

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var payBtnClick: UIButton!
    var currentIndex = 0
    var nav = DXNavgationBar.getNav("付款方式")
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.statusBarStyle = .default
    }
    func createUI() -> () {
        self.view .addSubview(self.nav)
        
        self.nav.addBackBtn(self, backSelector: #selector(PayMoneyViewController.backClick(_:)))
        self.view.backgroundColor = bgColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        self.tableView.backgroundColor = UIColor.clear
        self.payBtn.backgroundColor = UIColor.black
        self.payBtn.layer.cornerRadius = 5
        self.payBtn.layer.masksToBounds = true
        
    }
    func backClick(_ sender:UIButton?) {
        
        if self.navigationController?.popViewController(animated: true) != nil {
            
        }
        
    }

    //MARK : UITableViewDelegate,UITableViewDataSource
   // func
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : PayWayTableViewCell = tableView.dequeueReusableCell(withIdentifier: "PayWayTableViewCell", for: indexPath) as! PayWayTableViewCell
        switch indexPath.row {
        case 0:
            cell.iconImageView.image = UIImage(named:"绿色logo");
            cell.payNameLable.text = "微信支付";
            cell.payDesLable.text = "亿万用户选择,更快更安全";

            break;
        case 1:
            cell.iconImageView.image = UIImage(named:"paybaoIcon");
            cell.payNameLable.text = "支付宝支付";
            cell.payDesLable.text = "支付宝支付";

            break;
        default:
            break;
        }
        if (indexPath.row != currentIndex){
            cell.selectImageView.image = UIImage(named:"selectNormalImage");
        } else {
            cell.selectImageView.image = UIImage(named:"selectedImage");
        }
        cell.backgroundColor = UIColor.clear;

        return cell
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
