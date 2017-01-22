//
//  FuqianlaPay+scheme.m
//  CEFastPayAggrDemo
//
//  Created by zzf073 on 17/1/11.
//  Copyright © 2017年 zzf073. All rights reserved.
//

#import "FuqianlaPay+scheme.h"

@implementation FuqianlaPay (scheme)

@dynamic callBackScheme;

-(NSString*)callBackScheme
{
   return @"fqianlaseemoney";
}

-(void)setCallBackScheme:(NSString *)callBackScheme
{
    
}
- (void)myStart {

    [self startPayAction];
}
- (void)payFor:(NSString *)subject order:(NSString *)orderid body:(NSString *)body way:(CEPayType)way amount:(CGFloat)money callBack:(void (^)(CEPaymentStatus status))block {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.showPayStatusView = NO;
        
        self.transactionParams = @{
                                   @"app_id":@"UOIcpKx4jipj1WM3Wn2Tjw", @"order_no":orderid,
                                   @"pmtTp":@(way),//     app
                                   @"amount":[NSString stringWithFormat:@"%.2f",money],
                                   @"subject":subject,
                                   @"body":body,
                                   @"notify_url":@"http://10.100.140.124:8081/adapter-client/receive/notify.htm", };
        self.payStatusCallBack = ^(CEPaymentStatus payStatus, NSString *result){
            if (block) {
                block(payStatus);
            }
        };
        
        [self startPayAction];

    });

}
@end
