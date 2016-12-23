//
//  SlideBtn.swift
//  SeeMoney
//
//  Created by douglas on 2016/12/22.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class SlideBtn: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.size.width/2 - 40, y: contentRect.size.height/2 - 7.5, width: 15, height: 15)
    }
    override func titleRect(forContentRect contentRect: CGRect) -> CGRect {
        return CGRect(x: contentRect.size.width/2 - 15, y: contentRect.size.height/2 - 10, width: contentRect.size.width/2 + 15, height: 20)
    }

}
