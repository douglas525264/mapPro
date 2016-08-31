//
//  OpenRedBagViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/31.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class OpenRedBagViewController: UIViewController {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var bgBottomView: UIView!
    @IBOutlet weak var bgHeaderView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var detailLable: UILabel!
    @IBOutlet weak var openBtn: UIButton!
    weak var parentVc:UIViewController?
    var redBag:redbagModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bgHeaderView.backgroundColor = UIColor.clearColor()
        self.bgHeaderView.layer.shadowColor = UIColor.blackColor().CGColor
        self.bgHeaderView.layer.shadowRadius = 2
        self.bgHeaderView.layer.shadowOffset = CGSizeMake(0, 1)
        self.bgHeaderView.layer.shadowOpacity = 0.2
        self.bgBottomView.backgroundColor = RGB(214, g: 79, b: 71, a: 1)
        self.openBtn.backgroundColor = RGB(220, g: 187, b: 135, a: 1)
        self.openBtn.layer.cornerRadius = 35
    
        self.openBtn.layer.masksToBounds = true
        self.detailLable.textColor = RGB(254, g: 225, b: 180, a: 1)
        self.view.backgroundColor = RGB(0, g: 0, b: 0, a: 0.6)
        self.bgView.layer.cornerRadius = 5
        self.bgView.layer.masksToBounds = true
        let bgBtn = UIButton(type: UIButtonType.Custom)
        bgBtn.frame = self.view.bounds
        bgBtn.addTarget(self, action: #selector(OpenRedBagViewController.oneTapClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.insertSubview(bgBtn, atIndex: 0)
        

        
        //self.closeBtn .setTitleColor(RGB(0, g: 0, b: 0, a: 0.6), forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }
    func show(inView view:UIView) -> Void {
        view.addSubview(self.view)
    }
    func oneTapClick(sender:AnyObject) {
        self.view.removeFromSuperview()
    }
    @IBAction func openBtnCLick(sender: AnyObject) {
        //这里需要执行 开红包动画 或者 利用转场动画实现
        if self.parentVc != nil {
            let me = UserManager.shareInstance.getMe()
             me.accountNum += (self.redBag?.num)!
             UserManager.shareInstance.saveModel(me)
            
            let story = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            
            let detailVc   = story.instantiateViewControllerWithIdentifier("RedBagDetailViewController") as! RedBagDetailViewController
            self.redBag?.status = bagStatus.bagStatusHasOpen
            detailVc.redBag = self.redBag
            self.parentVc?.presentViewController(detailVc, animated: true, completion: { 
                self.view.removeFromSuperview()
            })
            MapManager.sharedInstance.removeBag(self.redBag!)
        }
    }
    @IBAction func closeBtnClick(sender: AnyObject) {
        self.view.removeFromSuperview()
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
