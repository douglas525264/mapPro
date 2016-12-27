//
//  DXNavgationBar.swift
//  SeeMoney
//
//  Created by douglas on 16/8/24.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class DXNavgationBar: UIView {

    class func getNav(_ title:String?) -> DXNavgationBar{
        let nav = DXNavgationBar(frame: CGRect(x: 0,y: 0,width: ScreenWidth!,height: 64))
        nav.backgroundColor = RGB(248, g: 248, b: 248, a: 1)
        nav.title = title
        //nav.addSubview(nav.bgView)
        //nav.sendSubview(toBack: nav.bgView)
        nav.bgView.frame = nav.bounds
        nav.addSubview(nav.linelable)
        return nav
    }
    var title:String? {
    
        didSet{
            if self.titlelable.superview == nil {
                self .addSubview(self.titlelable)
            }
            var cen = self.center
            cen.y += 10
            self.titlelable.center = cen
            self.titlelable.text = title
            
        }
    }
    lazy var bgView: UIVisualEffectView  = {
        
        let effect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let eview = UIVisualEffectView(effect: effect)
        
        return eview
    }()
    lazy var titlelable: UILabel = {
        
        let la = UILabel(frame: CGRect(x: 0,y: 0,width: 80,height: 40))
        la.font = UIFont.systemFont(ofSize: 17)
        la.textColor = UIColor.black
        la.textAlignment = NSTextAlignment.center
        return la
    }()
    lazy var linelable: UILabel = {
        
        let la = UILabel(frame: CGRect(x: 0,y: 63.5,width: ScreenWidth!,height: 0.5))
        la.backgroundColor = RGB(187, g: 185, b: 179, a: 1)
        return la
    }()

    var leftItems:[UIBarButtonItem]?{
        
        willSet{
            
            if self.leftItems?.count > 0 {
                for item in self.leftItems! {
                    item.customView?.removeFromSuperview()
                }
            }
        }
        didSet{
            var i = 0
            for item in self.leftItems! {
                item.customView?.frame = CGRect(x: 15 + 40 * CGFloat(i), y: (self.frame.height - 20)/2 - 15 + 20, width: 30, height: 30)
                self .addSubview(item.customView!)
                i += 1
            }
        }
    }
    var rightItems:[UIBarButtonItem]?{
        
        willSet{
            if self.rightItems?.count > 0 {
                for item in self.rightItems! {
                    item.customView?.removeFromSuperview()
                }
            }
        }
        didSet{
            var i = 0
            var currentW : CGFloat = 15.0
            for item in self.rightItems! {
                currentW += (item.customView?.frame.width)!
                item.customView?.frame = CGRect(x: self.frame.width - currentW, y: (self.frame.height - 20)/2 - 15 + 20, width: (item.customView?.frame.width)!, height: 30)
                
                self .addSubview(item.customView!)
                
                i += 1
            }
        }
    }
    func addBackBtn(_ target: AnyObject? ,backSelector:Selector) {
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.setImage(UIImage(named: "back"), for: UIControlState())
        backBtn.addTarget(target, action: backSelector, for: UIControlEvents.touchUpInside)
        let backItem = UIBarButtonItem(customView: backBtn)
        self.leftItems = [backItem]
        
    }

    
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
