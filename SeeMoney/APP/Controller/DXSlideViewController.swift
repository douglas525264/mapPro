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
    lazy var bgView = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth!, height: ScreenHeight!))
    lazy var slideView : UIView  = UIView(frame: CGRect(x: 0, y: 0, width: ScreenWidth! * 0.75, height: ScreenHeight!))
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createUI();
        // Do any additional setup after loading the view.
    }
    
    func createUI() -> Void {
        self.view.backgroundColor = UIColor.clear
        self.view.addSubview(bgView)
        self.view.addSubview(slideView)
        slideView.frame = CGRect(x: -slideView.frame.size.width, y: 0, width: slideView.frame.size.width, height: slideView.frame.size.height)
        bgView.backgroundColor = RGB(0, g: 0, b: 0, a: 1)
        bgView.alpha = 0.1
        
        slideView.backgroundColor = RGB(255, g: 255, b: 255, a: 1)
        slideView.addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.new, context: nil);
        
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
        
        UIApplication.shared.keyWindow?.addSubview(self.view)
        fixPosition(true) {
            
        }
    }
    func show(inView view:UIView) {
    
        view.addSubview(self.view)
        fixPosition(true) {
            
        }
    }
    func fixPosition(_ isShow:Bool,finishedBlock:@escaping ()->Void){
        if isShow {
            UIView.animate(withDuration: 0.55, animations: {
                self.slideView.frame = CGRect(x: 0, y: 0, width: self.slideView.frame.size.width, height: self.slideView.frame.size.height)
                }, completion: { (isOK : Bool) in
                    finishedBlock()
            })
            
        } else {
            
            UIView.animate(withDuration: 0.55, animations: {
                self.slideView.frame = CGRect(x: -self.slideView.frame.size.width, y: 0, width: self.slideView.frame.size.width, height: self.slideView.frame.size.height)
                }, completion: { (isOK : Bool) in
                    finishedBlock()
            })
        }
    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        self.bgView.alpha = 0.1 + 0.3 * (self.slideView.frame.origin.x + self.slideView.frame.width)/self.slideView.frame.width;
    }
    func dismiss(){
        fixPosition(false) {
            self.view.removeFromSuperview()
        }
        
    }
    func oneTap(_ sender:UIGestureRecognizer) {
        self.dismiss()
    }
    func longpress(_ sender:UIPanGestureRecognizer) {
        let point = sender.translation(in: sender.view)
        sender.setTranslation(CGPoint.zero, in: sender.view)
        
        switch sender.state {
        case UIGestureRecognizerState.began,UIGestureRecognizerState.changed:
            
            var frame = self.slideView.frame
            frame.origin.x += point.x
            if (frame.origin.x < 0 && -frame.origin.x < self.slideView.frame.width) {
                self.slideView.frame = frame
            }
            
            break
        case UIGestureRecognizerState.ended:
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
