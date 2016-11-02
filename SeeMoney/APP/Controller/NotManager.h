//
//  NotManager.h
//  SeeMoney
//
//  Created by douglas on 2016/10/26.
//  Copyright © 2016年 douglas. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JPUSHService.h"
@interface NotManager : NSObject
+ (void)registerNotWithDlegate:(id<JPUSHRegisterDelegate>)de;
@end
