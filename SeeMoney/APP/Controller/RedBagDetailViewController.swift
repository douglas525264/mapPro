//
//  RedBagDetailViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/31.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class RedBagDetailViewController: UIViewController {
    var redBag : redbagModel?
    
    @IBOutlet weak var numLable: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.redBag != nil {
            switch self.redBag!.bagType {
                
            case redBagType.redBagTypeGold:
                self.numLable.text = String(format: "%.0f 个金币", (self.redBag?.num)!)
                break;
            case redBagType.redBagTypeMoney:
                self.numLable.text = String(format: "%.2f元", (self.redBag?.num)!)
                break;
                
            default:
                break;
            }
            
        }
        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var backBtn: UIButton!

    @IBAction func backBtnClick(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { 
            
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
