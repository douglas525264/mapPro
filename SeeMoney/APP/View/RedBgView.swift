//
//  redBgView.swift
//  SeeMoney
//
//  Created by douglas on 16/9/1.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class RedBgView: UIView {
    @IBOutlet weak var openBtn: UIButton!

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var deView: UILabel!
    @IBOutlet weak var bgHeaderView: RedBagHeaderView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var TestLable: UILabel!
    weak var parentVC:UIViewController?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.bgHeaderView.backgroundColor = UIColor.clearColor()
        self.bgHeaderView.layer.shadowColor = UIColor.blackColor().CGColor
        self.bgHeaderView.layer.shadowRadius = 2
        self.bgHeaderView.layer.shadowOffset = CGSizeMake(0, 1)
        self.bgHeaderView.layer.shadowOpacity = 0.2
        self.bottomView.backgroundColor = RGB(214, g: 79, b: 71, a: 1)
        self.openBtn.backgroundColor = RGB(220, g: 187, b: 135, a: 1)
        self.openBtn.layer.cornerRadius = 35
        
        self.openBtn.layer.masksToBounds = true
        self.deView.textColor = RGB(254, g: 225, b: 180, a: 1)
       
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true

    }
    func showBtnAnimation() -> Void {
        //self.TestLable.frame = self.openBtn.frame
      //  self.TestLable.frame = self.openBtn.frame
        let ani = CABasicAnimation(keyPath: "transform")
        ani.toValue = NSValue(CATransform3D: CATransform3DMakeRotation(3.1415926, 0, 1, 0))
        ani.duration = 1
        ani.repeatCount = 1000
        ani.autoreverses = true
        self.openBtn.layer.addAnimation(ani, forKey: kCAAnimationRotateAuto)
        
    }
    func stopBtnAnimation() -> Void {
        self.openBtn.layer.removeAnimationForKey(kCAAnimationRotateAuto)
    }
    func scaleBgView(finished:(isOk:Bool)->Void) -> Void {
        if self.parentVC != nil {
            var frame = self.frame
            frame.size.width = (self.parentVC?.view.bounds.width)!
            frame.origin.x = 0
            UIView.animateWithDuration(0.8, animations: {
                self.frame = (self.parentVC?.view.bounds)!
                self.openBtn.alpha = 0;
                self.closeBtn.alpha = 0;
                self.deView.alpha = 0;
                }, completion: { (ok:Bool) in
                 finished(isOk: ok)
            })
           
            
        }
        
    }

}