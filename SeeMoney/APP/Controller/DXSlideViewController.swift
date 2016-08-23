//
//  DXSlideViewController.swift
//  SeeMoney
//
//  Created by douglas on 16/8/23.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class DXSlideViewController: UIViewController {

    let slideW = 0.75
    lazy var bgView = UIView(frame: CGRectMake(0, 0, ScreenWidth!, ScreenHeight!))
    lazy var slideView : UIView  = UIView(frame: CGRectMake(0, 0, ScreenWidth! * 0.75, ScreenHeight!))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI();
        // Do any additional setup after loading the view.
    }
    
    func createUI() -> Void {
        self.view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(bgView)
        self.view.addSubview(slideView)
        slideView.frame = CGRectMake(-slideView.frame.size.width, 0, slideView.frame.size.width, slideView.frame.size.height)
        bgView.backgroundColor = RGB(0, g: 0, b: 0, a: 1)
        bgView.alpha = 0.1
        
        slideView.backgroundColor = RGB(255, g: 255, b: 255, a: 1)
        slideView.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil);
        
        //        slideView.rac_observeKeyPath("frame", options: NSKeyValueObservingOptions.New, observer: self) { (value:AnyObject!, dic:[NSObject : AnyObject]!, a:Bool, b:Bool) in
        //            self.bgView.alpha = 0.2 + 0.4 * (self.slideView.frame.origin.x + self.slideView.frame.width)/self.slideView.frame.width;
        //        }
        
        let onetapGes = UITapGestureRecognizer(target: self, action: #selector(SlideViewController.oneTap(_:)));
        onetapGes.numberOfTapsRequired = 1;
        bgView.addGestureRecognizer(onetapGes)
        let panGes = UIPanGestureRecognizer(target: self, action:  #selector(SlideViewController.longpress(_:)))
        self.view.addGestureRecognizer(panGes)
        
    }
    func show(){
        
        UIApplication.sharedApplication().keyWindow?.addSubview(self.view)
        fixPosition(true) {
            
        }
    }
    func show(inView view:UIView) {
    
        view.addSubview(self.view)
        fixPosition(true) {
            
        }
    }
    func fixPosition(isShow:Bool,finishedBlock:()->Void){
        if isShow {
            UIView.animateWithDuration(0.55, animations: {
                self.slideView.frame = CGRectMake(0, 0, self.slideView.frame.size.width, self.slideView.frame.size.height)
                }, completion: { (isOK : Bool) in
                    finishedBlock()
            })
            
        } else {
            
            UIView.animateWithDuration(0.55, animations: {
                self.slideView.frame = CGRectMake(-self.slideView.frame.size.width, 0, self.slideView.frame.size.width, self.slideView.frame.size.height)
                }, completion: { (isOK : Bool) in
                    finishedBlock()
            })
        }
    }
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        self.bgView.alpha = 0.1 + 0.3 * (self.slideView.frame.origin.x + self.slideView.frame.width)/self.slideView.frame.width;
    }
    func dismiss(){
        fixPosition(false) {
            self.view.removeFromSuperview()
        }
        
    }
    func oneTap(sender:UIGestureRecognizer) {
        self.dismiss()
    }
    func longpress(sender:UIPanGestureRecognizer) {
        let point = sender.translationInView(sender.view)
        sender.setTranslation(CGPointZero, inView: sender.view)
        
        switch sender.state {
        case UIGestureRecognizerState.Began,UIGestureRecognizerState.Changed:
            
            var frame = self.slideView.frame
            frame.origin.x += point.x
            if (frame.origin.x < 0 && -frame.origin.x < self.slideView.frame.width) {
                self.slideView.frame = frame
            }
            
            break
        case UIGestureRecognizerState.Ended:
            print(self.slideView.frame)
            
            if -self.slideView.frame.origin.x > self.slideView.frame.width * 0.5 {
                self.dismiss()
            } else {
                self.show()
            }
            
            break
        default: break
            
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
