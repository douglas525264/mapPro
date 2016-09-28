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
    var minAnimationTime = 3
    var startTime:Date?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        self.bgHeaderView.backgroundColor = UIColor.clear
        self.bgHeaderView.layer.shadowColor = UIColor.black.cgColor
        self.bgHeaderView.layer.shadowRadius = 2
        self.bgHeaderView.layer.shadowOffset = CGSize(width: 0, height: 1)
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
        ani.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(3.1415926, 0, 1, 0))
        ani.duration = 1
        ani.repeatCount = 1000
        ani.autoreverses = true
        self.openBtn.layer.add(ani, forKey: kCAAnimationRotateAuto)
        self.startTime = Date()
        
    }
    func stopBtnAnimation(_ finishedBlock:@escaping ()->Void) -> Void {
        let currentdate = Date()
        let jiange =   currentdate.timeIntervalSince1970 - self.startTime!.timeIntervalSince1970
        if jiange < 2  {
            
         DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2*Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
            self.openBtn.layer.removeAnimation(forKey: kCAAnimationRotateAuto)
            finishedBlock()
         })
        }else {
            self.openBtn.layer.removeAnimation(forKey: kCAAnimationRotateAuto)
            finishedBlock()

        }
        
    }
    func scaleBgView(_ finished:@escaping (_ isOk:Bool)->Void) -> Void {
        if self.parentVC != nil {
            var frame = self.frame
            frame.size.width = (self.parentVC?.view.bounds.width)!
            frame.origin.x = 0
            self.frame = frame
            UIView.animate(withDuration: 0.7, animations: {
                
                var lastfrom = self.parentVC?.view.bounds
                lastfrom?.size.height *= 1.7
                lastfrom?.origin.y = -(0.35 * (self.parentVC?.view.bounds.size.height)!)
                self.frame = lastfrom!
                self.openBtn.alpha = 0;
                self.closeBtn.alpha = 0;
                self.deView.alpha = 0;
                }, completion: { (ok:Bool) in
                 finished(ok)
            })
           
            
        }
        
    }

}
