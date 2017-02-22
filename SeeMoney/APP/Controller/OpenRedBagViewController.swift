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
        let bgBtn = UIButton(type: UIButtonType.custom)
        bgBtn.frame = self.view.bounds
        bgBtn.addTarget(self, action: #selector(OpenRedBagViewController.oneTapClick(_:)), for: UIControlEvents.touchUpInside)
        self.view.insertSubview(bgBtn, at: 0)
        
        self.bgView = Bundle.main.loadNibNamed("RedBgView", owner: self, options: nil)!.last as? RedBgView
        self.bgView?.frame = CGRect(x: 30, y: 150, width: self.view.frame.size.width - 60, height: self.view.frame.size.height - 150 - 80)
        self.bgView?.parentVC = self
        self.bgView?.closeBtn.addTarget(self, action:  #selector(OpenRedBagViewController.closeBtnClick(_:)), for: UIControlEvents.touchUpInside)
        self.bgView?.openBtn.addTarget(self, action:  #selector(OpenRedBagViewController.openBtnCLick(_:)), for: UIControlEvents.touchUpInside)
        self.view .addSubview(self.bgView!)
        
       // self.bgView?.backgroundColor = UIColor.orangeColor()
        //self.closeBtn .setTitleColor(RGB(0, g: 0, b: 0, a: 0.6), forState: UIControlState.Normal)
        // Do any additional setup after loading the view.
    }
    func show(inView view:UIView) -> Void {
        view.addSubview(self.view)
    }
    func oneTapClick(_ sender:AnyObject) {
        self.view.removeFromSuperview()
    }
    func openBtnCLick(_ sender: AnyObject) {
        //这里需要执行 开红包动画 或者 利用转场动画实现
        if self.parentVc != nil {
            self.bgView?.showBtnAnimation()
            
            RedBagManager.sharedInstance.pick((self.redBag?.redID)!, type: (redBag?.bagType)! , finishedBlock: { (isOK,msg,info) in
                
                self.bgView?.stopBtnAnimation({ 
                    if isOK {
                        
                        if let arr = info?["pickInfos"] {
                        
                            self.redBag?.pickList = arr as? Array<Any>;
                        }
                        
                        let story = UIStoryboard(name: "Main", bundle: Bundle.main)
                        
                        let detailVc   = story.instantiateViewController(withIdentifier: "RedBagDetailViewController") as! RedBagDetailViewController
                        self.redBag?.status = bagStatus.bagStatusHasOpen
                        detailVc.redBag = self.redBag
                        
                        self.bgView?.scaleBgView({ (isOk) in
                            self.parentVc?.present(detailVc, animated: false, completion: {
                                self.view.removeFromSuperview()
                            })
                        })
                        
                        
                        
                        MapManager.sharedInstance.removeBag(redbg: self.redBag!)
                        UserManager.shareInstance.updateInfo();
                        
                    }else {
                        
                        DXHelper.shareInstance.makeAlert("没打开", dur: 1, isShake: false)
                    }

                })
            })
            
        }
    }
    func closeBtnClick(_ sender: AnyObject) {
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
