//
//  AppDelegate.swift
//  SeeMoney
//
//  Created by douglas on 16/8/18.
//  Copyright © 2016年 douglas. All rights reserved.
//

import UIKit
import UserNotifications
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,JPUSHRegisterDelegate,UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        /*
         
         if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
         JPUSHRegisterEntity * entity = [[JPUSHRegisterEntity alloc] init];
         entity.types = UNAuthorizationOptionAlert|UNAuthorizationOptionBadge|UNAuthorizationOptionSound;
         [JPUSHService registerForRemoteNotificationConfig:entity delegate:self];
         }
         else if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
         //可以添加自定义categories
         [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
         UIUserNotificationTypeSound |
         UIUserNotificationTypeAlert)
         categories:nil];
         }
         else {
         //categories 必须为nil
         [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound |
         UIRemoteNotificationTypeAlert)
         categories:nil];
         }
         
         //Required
         // init Push(2.1.5版本的SDK新增的注册方法，改成可上报IDFA，如果没有使用IDFA直接传nil  )
         // 如需继续使用pushConfig.plist文件声明appKey等配置内容，请依旧使用[JPUSHService setupWithOption:launchOptions]方式初始化。
         [JPUSHService setupWithOption:launchOptions appKey:appKey
         channel:channel
         apsForProduction:isProduction
         advertisingIdentifier:advertisingId];
         */
 
            // 使用 UNUserNotificationCenter 来管理通知
           /* if #available(iOS 10.0, *) {
                let center = UNUserNotificationCenter.current()
                //监听回调事件
                center.delegate = self;
                
                //iOS 10 使用以下方法注册，才能得到授权
                center.requestAuthorization(options: [UNAuthorizationOptions.alert,UNAuthorizationOptions.badge], completionHandler: { (granted:Bool, error:Error?) -> Void in
                    if (granted) {
                        //点击允许
                        print("注册通知成功")
                        //获取当前的通知设置，UNNotificationSettings 是只读对象，不能直接修改，只能通过以下方法获取
                        center.getNotificationSettings(completionHandler: { (settings:UNNotificationSettings) in
                            print("2222222222")
                        })
                    } else {
                        //点击不允许
                        print("注册通知失败")
                    }
                })
                UIApplication.shared.registerForRemoteNotifications()

            } else {
                // Fallback on earlier versions
            }*/
        
             NotManager.registerNot(withDlegate: self)
            let defCenter = NotificationCenter.default;
            defCenter.addObserver(self, selector:#selector(AppDelegate.networkDidReceiveMessage(_:)), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
            JPUSHService.setup(withOption: launchOptions, appKey: "78fecb328e06d3d8a7affd04", channel: "Publish channel", apsForProduction: false)

        
            
            return true
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print("get \(response.notification.request.content.userInfo)")
        completionHandler();
        
    }
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ( (Int) -> Void)!) {
        completionHandler(1|2|3);
    }
    func networkDidReceiveMessage(_ not: Notification) -> Void {
        print("get msg")
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
        application.applicationIconBadgeNumber = 0;
        application.cancelAllLocalNotifications();
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("DeviceToken : \(deviceToken)")
        JPUSHService.registerDeviceToken(deviceToken)
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        JPUSHService .handleRemoteNotification(userInfo)
        print("receive : \(userInfo)")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService .handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData);
    }
    


}

