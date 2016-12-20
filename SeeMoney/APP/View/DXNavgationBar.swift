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
        nav.backgroundColor = UIColor.black
        nav.title = title
        nav.addSubview(nav.bgView)
        nav.bgView.frame = nav.bounds
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
        
        let effect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let eview = UIVisualEffectView(effect: effect)
        
        return eview
    }()
    lazy var titlelable: UILabel = {
        
        let la = UILabel(frame: CGRect(x: 0,y: 0,width: 80,height: 40))
        la.font = UIFont.systemFont(ofSize: 16)
        la.textColor = UIColor.white
        la.textAlignment = NSTextAlignment.center
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
                item.customView?.frame = CGRect(x: 0 + 40 * CGFloat(i), y: (self.frame.height - 20)/2, width: 40, height: 40)
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
            for item in self.rightItems! {
                item.customView?.frame = CGRect(x: self.frame.width - (0 + 40 * CGFloat(i)), y: (self.frame.height - 20)/2 - 20, width: 40, height: 40)
                self .addSubview(item.customView!)
                i += 1
            }
        }
    }
    func addBackBtn(_ target: AnyObject? ,backSelector:Selector) {
        let backBtn = UIButton(type: UIButtonType.custom)
        backBtn.setImage(UIImage(named: "radarBackBg"), for: UIControlState())
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
