//
//  FuqianlaPay+scheme.h
//  CEFastPayAggrDemo
//
//  Created by zzf073 on 17/1/11.
//  Copyright © 2017年 zzf073. All rights reserved.
//

#import "FuqianlaPay.h"

@interface FuqianlaPay (scheme)

@property(nonatomic, strong) NSString *callBackScheme;

- (void)myStart;
- (void)payFor:(NSString *)subject order:(NSString *)orderid body:(NSString *)body way:(CEPayType)way amount:(CGFloat)money callBack:(void (^)(CEPaymentStatus status))block;
@end
