//
//  DXHelper.swift
//  SeeMoney
//
//  Created by douglas on 16/8/19.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import AudioToolbox
import ATMHud_dhoerl
class DXHelper: NSObject {
    
    static let shareInstance = DXHelper()
    let atmhud:ATMHud = {
    
        return ATMHud()
    }()
    
    func makeShake() -> Void {
       AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    func makeAlert(_ title:String, dur:TimeInterval, isShake:Bool) -> Void {
        self.atmhud.setCaption(title)
        self.atmhud.minShowTime = dur
        self.atmhud .show(in: UIApplication.shared.keyWindow)
        self.atmhud.hide()
        if isShake { makeShake() }
        
    }
    
}
