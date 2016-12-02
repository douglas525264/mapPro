//
//  ToolListViewController.swift
//  SeeMoney
//
//  Created by douglas on 2016/11/24.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class ToolListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var nav = DXNavgationBar.getNav("道具")
    
    var tableview : UITableView = UITableView(frame: CGRect(x: 0, y: 64, width: 0, height: 0), style: UITableViewStyle.plain) {
    
        willSet(newTable){
            
            newTable.delegate = self
            newTable.dataSource = self
            newTable.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
            newTable.separatorStyle = UITableViewCellSeparatorStyle.none
            self.view.insertSubview(newTable, at: 0);
            
        }
    }
    
    var sourceArr = [ToolModel]()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view .addSubview(self.nav)
        self.nav.addBackBtn(self, backSelector: #selector(ToolListViewController.backClick(_:)))
        self.tableview = UITableView(frame: CGRect(x: 0, y: 64, width: 0, height: 0), style: UITableViewStyle.plain);
        self.loadData()
        // Do any additional setup after loading the view.
    }
    func backClick(_ sender:UIButton?) {
        
        self.navigationController!.popViewController(animated: true);
    }
    
    func createUI() -> Void{
    
        
    }
    func loadData() -> Void {
        
        ToolManager.shareInstance.getToolList { (list : Array<ToolModel>?) in
            self.sourceArr .removeAll()
        
            self.sourceArr = list!
            self.tableview.reloadData()
        }
        
    }
    //MARK - UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sourceArr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celltag = "celltag"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: celltag)
        
        if cell == nil {
            
            cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: celltag);
            
        }
        let tool : ToolModel = self.sourceArr[indexPath.row]
        print("image URL : \(tool.iconUrl)")
       // cell?.imageView?.setImageWith(URL(string: tool.iconUrl!)!)
      
        cell!.imageView?.setImageWith(URL(string: tool.iconUrl!)!, placeholderImage: UIImage(named: "redbg2"))
        cell?.textLabel?.text = tool.des
        cell?.detailTextLabel?.text = "价格:\(tool.price)";
        return cell!;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tool : ToolModel = self.sourceArr[indexPath.row]
        //买买买
        ToolManager.shareInstance.buyTool(tool.type, 1) {
            
            print("已经购买")
            UserManager.shareInstance.updateInfo()
        }
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
