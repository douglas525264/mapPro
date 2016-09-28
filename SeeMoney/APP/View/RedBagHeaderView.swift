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
    override func draw(_ rect: CGRect) {
        // Drawing code
        let height = rect.size.height - 35
        let context = UIGraphicsGetCurrentContext();
        context!.move(to: CGPoint(x: 0, y: 0))
        context!.addLine(to: CGPoint(x: rect.size.width, y: 0))
        context!.addLine(to: CGPoint(x: rect.size.width, y: height - 15))
//        CGContextAddLineToPoint(context, 0, rect.size.height - 15)
//        CGContextAddLineToPoint(context, 0,0)
        context?.addQuadCurve(to: CGPoint(x:rect.size.width/2, y: height + 15), control: CGPoint(x: 0, y: height - 15))
      //  CGContextAddQuadCurveToPoint(context!, rect.size.width/2, height + 15, 0, height - 15)
        context!.closePath();
      //  CGContextSetLineWidth(context, 1)
        
        context!.setFillColor(RGB(233, g: 85, b: 78, a: 1).cgColor);
        
        context!.fillPath();
        //CGContextDrawPath(context, CGPathDrawingMode.Stroke)

        
    }


}
