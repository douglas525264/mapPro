//
//  SendRedBagViewController.swift
//  SeeMoney
//
//  Created by douglas on 2016/12/26.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class SendRedBagViewController: UIViewController {
    var nav = DXNavgationBar.getNav("发红包")
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = bgColor
        self.view .addSubview(nav)
        self.nav.addBackBtn(self, backSelector: #selector(SendRedBagViewController.backClick(_:)))
        // Do any additional setup after loading the view.
    }
    func backClick(_ sender:UIButton?) {
        
        if self.navigationController?.popViewController(animated: true) != nil {
        
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
