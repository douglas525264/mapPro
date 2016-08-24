//
//  DXNavgationBar.swift
//  SeeMoney
//
//  Created by douglas on 16/8/24.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class DXNavgationBar: UIView {

    class func getNav(title:String?) -> DXNavgationBar{
        let nav = DXNavgationBar(frame: CGRectMake(0,0,ScreenWidth!,64))
        nav.backgroundColor = UIColor.lightGrayColor()
        nav.title = title
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
    lazy var titlelable: UILabel = {
        
        let la = UILabel(frame: CGRectMake(0,0,80,40))
        la.font = UIFont.systemFontOfSize(16)
        la.textColor = UIColor.whiteColor()
        la.textAlignment = NSTextAlignment.Center
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
                item.customView?.frame = CGRectMake(0 + 40 * CGFloat(i), (self.frame.height - 20)/2, 40, 40)
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
                item.customView?.frame = CGRectMake(self.frame.width - (0 + 40 * CGFloat(i)), (self.frame.height - 20)/2 - 20, 40, 40)
                self .addSubview(item.customView!)
                i += 1
            }
        }
    }
    func addBackBtn(target: AnyObject? ,backSelector:Selector) {
        let backBtn = UIButton(type: UIButtonType.Custom)
        backBtn.setImage(UIImage(named: "radarBackBg"), forState: UIControlState.Normal)
        backBtn.addTarget(target, action: backSelector, forControlEvents: UIControlEvents.TouchUpInside)
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
