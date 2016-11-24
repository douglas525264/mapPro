//
//  ToolListViewController.swift
//  SeeMoney
//
//  Created by douglas on 2016/11/24.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class ToolListViewController: UIViewController {
    var nav = DXNavgationBar.getNav("道具")
//    let tableview = {
//    
//        var temp =  UITableView(frame: self.view.frame, style: UITableViewStyle.plain);
//    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view .addSubview(self.nav)
        self.nav.addBackBtn(self, backSelector: #selector(ToolListViewController.backClick(_:)))

        // Do any additional setup after loading the view.
    }
    func backClick(_ sender:UIButton?) {
        
        self.navigationController!.popViewController(animated: true);
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
