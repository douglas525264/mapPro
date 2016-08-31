//
//  RedBagHeaderView.swift
//  SeeMoney
//
//  Created by douglas on 16/8/31.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class RedBagHeaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        super.awakeFromNib()
     
    }
    override func drawRect(rect: CGRect) {
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        CGContextMoveToPoint(context, 0, 0)
        CGContextAddLineToPoint(context, rect.size.width, 0)
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height - 15)
//        CGContextAddLineToPoint(context, 0, rect.size.height - 15)
//        CGContextAddLineToPoint(context, 0,0)
        CGContextAddQuadCurveToPoint(context, rect.size.width/2, rect.size.height + 15, 0, rect.size.height - 15)
        CGContextClosePath(context);
      //  CGContextSetLineWidth(context, 1)
        
        CGContextSetFillColorWithColor(context,RGB(233, g: 85, b: 78, a: 1).CGColor);
        
        CGContextFillPath(context);
        //CGContextDrawPath(context, CGPathDrawingMode.Stroke)

        
    }


}
