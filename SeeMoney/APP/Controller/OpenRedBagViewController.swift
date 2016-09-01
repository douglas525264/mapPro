//
//  OpenRedBagViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/31.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class OpenRedBagViewController: UIViewController {


    weak var parentVc:UIViewController?
    var redBag:redbagModel?
    var bgView:RedBgView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(0, g: 0, b: 0, a: 0.6)
        let bgBtn = UIButton(type: UIButtonType.Custom)
        bgBtn.frame = self.view.bounds
        bgBtn.addTarget(self, action: #selector(OpenRedBagViewController.oneTapClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.insertSubview(bgBtn, atIndex: 0)
       self.bgView = NSBundle.mainBundle().loadNibNamed("RedBgView", owner: self, options: nil).last as? RedBgView
        self.bgView?.frame = CGRectMake(30, 150, self.view.frame.size.width - 60, self.view.frame.size.height - 150 - 80)
        self.bgView?.parentVC = self
        self.bgView?.closeBtn.addTarget(self, action:  #selector(OpenRedBagViewController.closeBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.bgView?.openBtn.addTarget(self, action:  #selector(OpenRedBagViewController.openBtnCLick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view .addSubview(self.bgView!)
       // self.bgView?.backgroundColor = UIColor.orangeColor()
        //self.closeBtn .setTitleColor(RGB(0, g: 0, b: 0, a: 0.6), forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }
    func show(inView view:UIView) -> Void {
        view.addSubview(self.view)
    }
    func oneTapClick(sender:AnyObject) {
        self.view.removeFromSuperview()
    }
    func openBtnCLick(sender: AnyObject) {
        //这里需要执行 开红包动画 或者 利用转场动画实现
        if self.parentVc != nil {
            self.bgView?.showBtnAnimation()
            RedBagManager.sharedInstance.pick((self.redBag?.redID)!, type: "1", finishedBlock: { (isOK, info) in
                self.bgView?.stopBtnAnimation()
                if isOK {
                    
                    let me = UserManager.shareInstance.getMe()
                    me.accountNum += (self.redBag?.num)!
                    UserManager.shareInstance.saveModel(me)
                    
                    let story = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
                    
                    let detailVc   = story.instantiateViewControllerWithIdentifier("RedBagDetailViewController") as! RedBagDetailViewController
                    self.redBag?.status = bagStatus.bagStatusHasOpen
                    detailVc.redBag = self.redBag
                    
                    self.bgView?.scaleBgView({ (isOk) in
                        self.parentVc?.presentViewController(detailVc, animated: false, completion: {
                            self.view.removeFromSuperview()
                        })
                    })

                    
                
                    MapManager.sharedInstance.removeBag(self.redBag!)

                }else {
                
                    DXHelper.shareInstance.makeAlert("没打开", dur: 1, isShake: false)
                }
            })
            
        }
    }
    func closeBtnClick(sender: AnyObject) {
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
