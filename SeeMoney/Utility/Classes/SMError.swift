//
//  SMError.swift
//  SeeMoney
//
//  Created by douglas on 16/8/31.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit

class SMError: NSObject {
    var code = 400
    var des : String {
    
        switch self.code {
        case 200:
            return ""
        
        default:
          return ""
        }
    }
    
    
}
