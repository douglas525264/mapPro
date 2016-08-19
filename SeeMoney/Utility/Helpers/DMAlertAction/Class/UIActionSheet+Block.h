//
//  UIActionSheet+Block.h
//
//
//  Created by jeffasd on 15/10/27.
//  Copyright © 2015年 jeffasd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIActionSheet (Block)<UIActionSheetDelegate>


- (void)showInView:(UIView *)view block:(void(^)(NSInteger idx))block;

@end
