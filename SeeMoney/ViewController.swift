//
//  ViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        DXNetWorkTool.sharedInstance.justATest()
        var color = UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

