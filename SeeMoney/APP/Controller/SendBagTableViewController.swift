//
//  SendBagTableViewController.swift
//  SeeMoney
//
//  Created by douglas on 2017/1/16.
//  Copyright © 2017年 douglas. All rights reserved.
//

import UIKit

class SendBagTableViewController: UITableViewController,UITextFieldDelegate {
    var nav = DXNavgationBar.getNav("发红包")
    var bagType:redBagType = .redBagTypeMoney
    var numCell : BagNumTableViewCell?
    var moneyCell : BagNumTableViewCell?
    var playWayCell : BagWayTableViewCell?
    var desCell : BagDesTableViewCell?
    var payCell : BuyTableViewCell?
    typealias payCompletedBlock = (_ payStatus : CEPaymentStatus) -> ()
    var payCallBack : payCompletedBlock?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createUI()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func createUI() -> () {
        view.backgroundColor = RGB(254, g: 250, b: 245, a: 1)
        self.navigationController?.navigationBar.barTintColor = RGB(212, g: 78, b: 71, a: 1)
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : RGB(254, g: 224, b: 179, a: 1)]
        self.title = "发红包"
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        leftBtn.setTitle("关闭", for: .normal)
        leftBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        leftBtn.setTitleColor(RGB(254, g: 224, b: 179, a: 1), for: .normal)
        leftBtn.addTarget(self, action: #selector(SendBagTableViewController.backClick(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        self.navigationController?.navigationBar.isTranslucent = false
        self.tableView.separatorStyle = .none
        
        let oneTap = UITapGestureRecognizer(target: self, action: #selector(SendBagTableViewController.oneTapClick))
        self.tableView.addGestureRecognizer(oneTap)
 
    }
    func backClick(_ sender:UIButton?) {
        self.dismiss(animated: true) { 
            
        };
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return bagType == .redBagTypeMoney ? 4:5
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 66
        case 1:
            return 66
        case 2:
            return 76
        case 3:
            return bagType == .redBagTypeMoney ? 130 : 76
        default:
            return 130
            
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 50}
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if ((self.bagType == .redBagTypeMoney && section == 2) || (self.bagType == .redBagTypePlayMoney && section == 3) ){
        
            return 1;
        }
        return 40
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.frame = CGRect(x: 0, y: 0, width: ScreenWidth!, height: section == 0 ? 50 : 1)
        footer.backgroundColor = UIColor.clear
        
        return footer
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
       
        var issamll = false
        issamll = (self.bagType == .redBagTypeMoney && section == 2) || (self.bagType == .redBagTypePlayMoney && section == 3)
        footer.frame = CGRect(x: 0, y: 0, width: ScreenWidth!, height: issamll ? 1 : 40)
        footer.backgroundColor = UIColor.clear
        if section == 1 {
            let lable = UILabel(frame: CGRect(x: 20, y: 10, width: ScreenWidth!, height: 20))
            lable.text = "当前为普通红包,"
            lable.adjust(with: UIFont.boldSystemFont(ofSize: 12))
            let lastLable = UILabel(frame: CGRect(x: 20 + lable.frame.size.width, y: 10, width: ScreenWidth!, height: 20))
            lastLable.text = "改变红包类型"
            lastLable.adjust(with: UIFont.boldSystemFont(ofSize: 12))

            let typeBtn = UIButton(type: .custom)
            
            typeBtn.frame = lastLable.frame
            typeBtn.setTitle(lastLable.text, for: .normal)
            typeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            typeBtn.setTitleColor(UIColor.blue, for: .normal)
            typeBtn.addTarget(section, action: #selector(SendBagTableViewController.changeTypeClick), for: .touchUpInside)
            footer.addSubview(lable)
            footer.addSubview(typeBtn)
            
        
        }
        return footer
    }
    func changeTypeClick() -> () {
        if self.bagType == .redBagTypeMoney {
            self.bagType = .redBagTypePlayMoney
        } else {
            self.bagType = .redBagTypeMoney
        }
        self.tableView.reloadData()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell;
        switch indexPath.section {
        case 0:
            if numCell == nil {
            numCell = tableView.dequeueReusableCell(withIdentifier:"BagNumTableViewCell", for: indexPath) as? BagNumTableViewCell
            numCell?.nameLable.text = "红包个数"
            numCell?.lastLable.text = "个"
            }
            numCell?.normalTextFiled.keyboardType = .numberPad
            numCell?.normalTextFiled.tag = 0;
            numCell?.normalTextFiled.returnKeyType = .done
            numCell?.normalTextFiled.delegate = self;
            cell = numCell!
            
            
            break;
        case 1:
            if moneyCell == nil {
                moneyCell = tableView.dequeueReusableCell(withIdentifier:"BagNumTableViewCell", for: indexPath) as? BagNumTableViewCell
                moneyCell?.nameLable.text = "金额"
                moneyCell?.lastLable.text = "元"
                moneyCell?.normalTextFiled.placeholder = "金额"
                moneyCell?.normalTextFiled.keyboardType = .decimalPad
                moneyCell?.normalTextFiled.tag = 1;
                moneyCell?.normalTextFiled.returnKeyType = .done
                moneyCell?.normalTextFiled.delegate = self
            }
            
            cell = moneyCell!

            break;
        case 2:
            if bagType == .redBagTypeMoney {
                if desCell == nil {
                    desCell = tableView.dequeueReusableCell(withIdentifier: "BagDesTableViewCell", for: indexPath) as? BagDesTableViewCell
                    desCell?.detailTextFiled.tag = 2;
                    desCell?.detailTextFiled.returnKeyType = .done
                    desCell?.detailTextFiled.delegate = self
                }
                cell = desCell!
            } else {
            
                if playWayCell == nil {
                    playWayCell = tableView.dequeueReusableCell(withIdentifier:"BagWayTableViewCell", for: indexPath) as? BagWayTableViewCell
                    let imagev = UIImageView(frame: CGRect(x: 30, y: 10, width: 40, height: 40))
                    imagev.image = UIImage(named: "gameicon")
                    playWayCell?.contentScrollView.addSubview(imagev)
                }
                cell = playWayCell!
            }
            
          
            break;
        case 3:
            if bagType != .redBagTypeMoney {
            if desCell == nil {
                desCell = tableView.dequeueReusableCell(withIdentifier: "BagDesTableViewCell", for: indexPath) as? BagDesTableViewCell
                desCell?.detailTextFiled.tag = 2;
                desCell?.detailTextFiled.returnKeyType = .done
                desCell?.detailTextFiled.delegate = self
                
            }
            cell = desCell!
            } else {
                if payCell == nil {
                    
                    payCell = tableView.dequeueReusableCell(withIdentifier: "BuyTableViewCell", for: indexPath) as? BuyTableViewCell
                    payCell?.selectionStyle = .none
                    payCell?.payBtn.layer.cornerRadius = 5;
                    payCell?.payBtn.layer.masksToBounds = true
                    payCell?.payBtn.backgroundColor = RGB(212, g: 78, b: 71, a: 1)
                    payCell?.payBtn.addTarget(self, action: #selector(SendBagTableViewController.payBtnClick), for: .touchUpInside)

                }
                cell = payCell!
            }

            break;
        case 4:
            
            if payCell == nil {
                
                payCell = tableView.dequeueReusableCell(withIdentifier: "BuyTableViewCell", for: indexPath) as? BuyTableViewCell
                payCell?.selectionStyle = .none
                payCell?.payBtn.layer.cornerRadius = 5;
                payCell?.payBtn.layer.masksToBounds = true
                payCell?.payBtn.backgroundColor = RGB(212, g: 78, b: 71, a: 1)
                payCell?.payBtn.addTarget(self, action: #selector(SendBagTableViewController.payBtnClick), for: .touchUpInside)
                
            }
            cell = payCell!
            
            break;
            
        default:
            cell = tableView.dequeueReusableCell(withIdentifier:"22", for: indexPath)
            break;
            
        }
        let bb = UIView()
        bb.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = bb
        cell.selectionStyle = .none
        return cell;
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string == "\n" {
            self.cancelRegister()
            return false;
        }
        if textField.tag == 1 {
        var ll = textField.text!
        if ll != nil && ll != "" {
            let startIndex = ll.index(ll.startIndex, offsetBy: range.location)
            let endIndexA = ll.index(startIndex, offsetBy: range.length)
            ll  = ll.replacingCharacters(in: Range(startIndex ..< endIndexA), with: string)
 
        } else {
        
            ll = string
        }
            if ll == "" {
             ll = "0"
            }
            let uu = String(format: "￥%.2f", Float(ll)!)
            payCell?.moneyLable.text = uu
        }
        return true;

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    func oneTapClick() -> () {
        self .cancelRegister()
    }
    func payBtnClick() -> () {
        let mainStory = UIStoryboard(name: "Main", bundle: Bundle.main)
        let payVC = mainStory.instantiateViewController(withIdentifier: "PayMoneyViewController") as! PayMoneyViewController
        payVC.name = "发红包"
        payVC.price = Float((moneyCell?.normalTextFiled.text!)!)!
        payVC.paytype = .payTypeRedBag
        payVC.payCallBack = { (_ payStatus : CEPaymentStatus) -> () in
            self.payCallBack?(payStatus)
            switch payStatus {
            case .payResultSuccess:
                let pp = Float((self.moneyCell?.normalTextFiled.text!)!)!
                var name = self.desCell?.detailTextFiled.text
                if name == "" {
                    name = "恭喜发财，大吉大利"
                }
                let size = Int((self.numCell?.normalTextFiled.text!)!)!
                let type = self.bagType
                let sub = 0;
                RedBagManager.sharedInstance.sendRedBag(pp * 100, size, type: type, title: name!, subType: sub, finishedBlock: { (isOK : Bool) in
                    if isOK {
                    
                        DXHelper.shareInstance.makeAlert("发送成功", dur: 2, isShake: false)
                        UserManager.shareInstance.updateInfo();
                        self.navigationController?.dismiss(animated: true, completion: { 
                            
                        })
 
                    }
                })
                
                break;
            default:
                break;
            }
        
        }
        self.navigationController?.pushViewController(payVC, animated: true)
    }
    func cancelRegister() -> () {
        if numCell != nil {
            numCell?.normalTextFiled.resignFirstResponder()
        }
        if moneyCell != nil {
            moneyCell?.normalTextFiled.resignFirstResponder()
        }
        if desCell != nil {
            desCell?.detailTextFiled.resignFirstResponder()
        }

    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
